require_relative "bearer_cli/version"
require_relative "bearer_cli/update_cli_service"

module BearerCli
  BIN = File.join(Gem.bindir, UpdateCliService::BIN_NAME)
end
