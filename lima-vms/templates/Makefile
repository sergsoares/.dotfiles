# Lima VM — claudelab (Debian 13 isolated)
# Template: debian13-isolated.yaml

LIMA_NAME := claudelab
LIMA_YAML := debian13-isolated.yaml

.PHONY: help start shell ssh stop delete

help:
	@echo "claudelab Lima VM (debian13-isolated.yaml)"
	@echo ""
	@echo "  make start   - Start VM (downloads ~400MB image on first run)"
	@echo "  make shell   - Open shell in VM (limactl shell)"
	@echo "  make ssh     - SSH directly (ssh -p 2222 user@localhost)"
	@echo "  make stop    - Stop VM"
	@echo "  make delete  - Delete VM"

start:
	limactl start --name=$(LIMA_NAME) $(LIMA_YAML)

shell:
	limactl shell $(LIMA_NAME)

ssh:
	ssh -p 2222 user@localhost

stop:
	limactl stop $(LIMA_NAME)

delete:
	limactl delete $(LIMA_NAME)
