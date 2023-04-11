# frozen_string_literal: true

module IpsService
  module Actions
    module IpStats
      class Index < IpsService::Action
        include Deps['repos.ip_stat_repo', 'repos.ip_repo']
        params do
          #TODO DateTime UTC format check
          required(:start_time).filled(:string)
          required(:start_time).filled(:string)
        end

        def handle(request, response)
          halt :unprocessable_entity, {errors: request.params.errors}.to_json unless request.params.valid?

          ip = ip_repo.find(request_params[:id]).one

          halt :unprocessable_entity, {errors: 'ip not exists'}.to_json if ip.nil?

          ip_stats = ip_stat_repo.get_stats_in_range(start_time: request.params.start_time,
                                                     end_time: request.params.end_time,
                                                     ip_address: ip[:ip_address])

          halt :unprocessable_entity, {errors: 'no stats yet'}.to_json if ip_stats.nil?

          response.status = :ok
          response.body = ip_stats.to_json
        end
      end
    end
  end
end
