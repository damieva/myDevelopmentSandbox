# ================================
# Terragrunt Makefile
# ================================

TG ?= terragrunt

.PHONY: help init plan apply destroy clean state-list state-rm

help:
	@echo ""
	@echo "Usage:"
	@echo "  make init"
	@echo "  make plan"
	@echo "  make apply"
	@echo "  make destroy"
	@echo "  make state-list"
	@echo "  make state-rm <terraform_address>"
	@echo ""

init:
	$(TG) run init --all

plan:
	$(TG) run plan --all

apply:
	$(TG) run apply --all

destroy:
	$(TG) run destroy --all

state-list:
	$(TG) run state list --all

# Positional argument trick for make
state-rm:
	@if [ -z "$(filter-out $@,$(MAKECMDGOALS))" ]; then \
		echo "ERROR: terraform resource address is required"; \
		echo "Usage: make state-rm <terraform_address>"; \
		exit 1; \
	fi
	$(TG) run state rm --all $(filter-out $@,$(MAKECMDGOALS))

clean:
	find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} +

# Prevent make from interpreting extra args as targets
%:
	@:
