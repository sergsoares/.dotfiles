# Claude Code Docker Template

This template provides a secure, reproducible Docker setup for running **Claude Code** and common cloud/dev tools against any project folder.

It is designed for **maximum security** while staying practical for everyday development.

## What's included

- **Base image**: `ubuntu:24.04`
- **Claude Code CLI** (via official installer)
- **.NET 8 SDK** (`dotnet-sdk-8.0`)
- **Go toolchain** (`golang-go`)
- **kubectl** (with checksum verification)
- **AWS CLI v2**
- Common CLI utilities: `git`, `curl`, `jq`, `vim`, etc.
- Non-root user `claude` with `/workspace` as the working directory

## Files

- `Dockerfile` – Builds the dev image with Claude Code + tooling.
- `docker-compose.yml` – Runs the container with secure defaults, persistent auth, and project mounts.
- `entrypoint.sh` – Tightens permissions and prepares the workspace and `.claude` directory.

## Volumes and persistence

By default, `docker-compose.yml` defines these mounts:

- **Claude home (named volume)**  
  - `claude-home:/home/claude`  
  - Stores user-level caches and tool state inside the container (isolated from the host).

- **Claude auth/config (host bind mount)**  
  - `${HOME}/.claude:/home/claude/.claude:rw`  
  - Persists Claude Code credentials and settings **on the host**, so:
    - You **log in once** with `claude auth login`.
    - You can **restart or recreate containers** without re-authenticating.

- **Project workspace**  
  - `./:/workspace:rw`  
  - Mounts the directory containing `docker-compose.yml` into `/workspace` so Claude and tools operate directly on your project files.

When using this template with **Podman**, you should additionally ensure that your host-level Claude configuration file is mounted:

- **Claude config file (host bind mount)**  
  - `${HOME}/.claude.json:/home/claude/.claude.json:rw`  
  - Persists any per-user Claude config JSON alongside the `.claude` directory.

## Security features

The compose service `claude-code` is configured with:

- **Non-root user** (`claude`) by default (from the `Dockerfile`).
- **`no-new-privileges`**: prevents privilege escalation within the container.
- **All Linux capabilities dropped** (`cap_drop: [ALL]`).
- **Read-only root filesystem** (`read_only: true`), with:
  - Writable home directory via the `claude-home` named volume.
  - Writable `.claude` config via the host bind mount.
  - Writable `/workspace` via the project bind mount.
  - Writable `/tmp` via a `tmpfs` mount.
- No host ports are exposed; outbound network access remains available for tools and APIs.
- Basic resource limits:
  - `mem_limit: 4g`
  - `cpus: 2.0`

> **Note**: If a specific tool fails due to filesystem restrictions, you can temporarily relax settings (for example, remove `read_only: true` or adjust volumes) on a per-project basis.

## Usage

1. **Copy the template into a project**

   From your project directory:

   ```bash
   init-claude
   ```

   This copies `Dockerfile`, `docker-compose.yml`, `entrypoint.sh`, and this `README.md`
   from your dotfiles template into the current directory (backing up existing files as
   `*.bak.<timestamp>` if they already exist).

2. **Build and start the container**

   In the project directory:

   ```bash
   docker compose up --build -d
   ```

3. **Exec into the container**

   ```bash
   docker compose exec claude-code bash
   ```

4. **Log in to Claude Code (first time only)**

   Inside the container:

   ```bash
   claude auth login
   ```

   Your credentials are stored in `/home/claude/.claude`, which is mounted from
   `${HOME}/.claude` on the host. After this, you can destroy and recreate the
   container without re-authenticating.

5. **Use Claude Code with your project**

   Still inside the container:

   ```bash
   cd /workspace
   claude
   ```

   Claude Code will operate against the mounted project directory.

## Using Podman instead of Docker

You can run the same image with **Podman** if you prefer. The `docker-compose.yml` remains compatible, but when invoking `podman run` directly you may want to mirror the host UID/GID using a user-namespace flag.

An example `podman run` command equivalent to the compose setup is:

```bash
podman run \
  -v "${HOME}/.claude:/home/claude/.claude" \
  -v "${HOME}/.claude.json:/home/claude/.claude.json" \
  -v "$PWD:/workspace" \
  --userns=keep-id:uid=1001,gid=1001 \
  claude-code-dev:latest
```

> **Note**: The `--userns=keep-id:uid=1001,gid=1001` flag is **Podman-specific** and is not represented in `docker-compose.yml`. It tells Podman to map your host user/group IDs into the container for better file-ownership alignment while still running the non-root `claude` user defined in the `Dockerfile`.

## Customization

- **Template location**
  - By default, the `init-claude` function (defined in your dotfiles) reads from:
    - `~/.dotfiles/docker/claude-code-template`
  - Override with:
    - `export CLAUDE_DOCKER_TEMPLATE_DIR=/path/to/your/template`

- **AWS / cloud credentials**
  - Standard environment variables (e.g. `AWS_PROFILE`, `AWS_REGION`, `AWS_ACCESS_KEY_ID`)
    are inherited from your shell when you run `docker compose` and can be explicitly
    passed via `environment:` or `.env` files if desired.

- **Resource limits**
  - Adjust `mem_limit` and `cpus` in `docker-compose.yml` per project.

- **Security vs. convenience**
  - To loosen restrictions, you can:
    - Remove `read_only: true`.
    - Remove or adjust `cap_drop`.
    - Add specific `cap_add` entries if a tool requires them.
  - To tighten further, consider:
    - Restricting environment variables passed into the container.
    - Using additional Docker security options (AppArmor/SELinux profiles) where applicable.

