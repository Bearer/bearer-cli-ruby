require 'open3'

module BearerCli
  class UpdateCliService
    BIN_NAME = "bearer-cli".freeze
    URL_BASE = "https://bearer-cli-binaries.s3.eu-west-1.amazonaws.com".freeze
    BINARY_NAME = "bearer-cli-latest".freeze

    def self.run(bindir)
      os = execute("uname -s | awk '{print tolower($0)}'")
      arch = execute("uname -p | awk '{print tolower($0)}'")
      uri = URI.parse(download_url(os, arch))

      executable = File.join(bindir, BIN_NAME)
      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        resp = http.get(uri.path)

        File.open(executable, "wb") do |file|
          file.write(resp.body)
        end
      end

      execute("chmod u+x #{executable}")
    end

    def self.download_url(os, arch)
      arch = execute("uname -m | awk '{print tolower($0)}'") if os == "linux"

      case arch
      when "i386"
        "#{URL_BASE}/#{os}/production/386/bin/#{BINARY_NAME}"
      when "x86_64"
        "#{URL_BASE}/#{os}/production/amd64/bin/#{BINARY_NAME}"
      when "aarch64"
        "#{URL_BASE}/#{os}/production/arm64/bin/#{BINARY_NAME}"
      end
    end

    def self.execute(cmd)
      Open3.capture3(cmd).first&.strip
    end
  end
end
