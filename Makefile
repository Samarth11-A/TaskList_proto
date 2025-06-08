.PHONY: generate check-tools

PROTOC := $(shell which protoc)
PROTOC_GEN_GO := $(shell which protoc-gen-go)
PROTOC_GEN_GO_GRPC := $(shell which protoc-gen-go-grpc)

PROTO_DIR := proto
OUT_DIR := .

GO_MODULE := github.com/Samarth11-A/TaskList_proto

generate: check-tools
	@echo "Generating Go code from proto files..."
	@mkdir -p $(OUT_DIR)
	$(PROTOC) -I $(PROTO_DIR) \
	  --go_out=$(OUT_DIR) --go_opt=module=$(GO_MODULE) \
	  --go-grpc_out=$(OUT_DIR) --go-grpc_opt=module=$(GO_MODULE) \
	  $(PROTO_DIR)/*.proto
	@echo "Code generation complete!"

check-tools:
	@echo "Checking for required tools..."
	@if [ -z "$(PROTOC)" ]; then \
		echo "Error: protoc is not installed. Please install it from https://github.com/protocolbuffers/protobuf/releases"; \
		exit 1; \
	fi
	@if [ -z "$(PROTOC_GEN_GO)" ]; then \
		echo "Error: protoc-gen-go is not installed. Install with: go install google.golang.org/protobuf/cmd/protoc-gen-go@latest"; \
		exit 1; \
	fi
	@if [ -z "$(PROTOC_GEN_GO_GRPC)" ]; then \
		echo "Error: protoc-gen-go-grpc is not installed. Install with: go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest"; \
		exit 1; \
	fi
	@echo "All required tools are available."
