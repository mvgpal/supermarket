require 'spec_helper'

describe 'GET /api/v1/cookbooks/:cookbook' do
  context 'when the cookbook exists' do
    let(:cookbook_signature) do
      {
        'name' => 'redis-test',
        'category' => 'Other',
        'maintainer' => 'Chef Software, Inc',
        'latest_version' => 'http://www.example.com/api/v1/cookbooks/redis-test/versions/0_2_0',
        'external_url' => nil,
        'versions' =>
          [
            'http://www.example.com/api/v1/cookbooks/redis-test/versions/0_2_0',
            'http://www.example.com/api/v1/cookbooks/redis-test/versions/0_1_0'
          ],
        'description' => 'Installs/Configures redis-test',
        'average_rating' => nil,
        'deprecated' => false
      }
    end

    before do
      share_cookbook(cookbook: 'redis-test-v1.tgz')
      share_cookbook(cookbook: 'redis-test-v2.tgz')
      get json_body['uri']
    end

    it 'returns a 200' do
      expect(response.status.to_i).to eql(200)
    end

    it 'returns the cookbook' do
      expect(signature(json_body)).to eql(cookbook_signature)
    end
  end

  context 'when the cookbook does not exist' do
    it 'returns a 404' do
      get '/api/v1/cookbooks/mamimi'

      expect(response.status.to_i).to eql(404)
    end

    it 'returns a 404 message' do
      get '/api/v1/cookbooks/mamimi'

      expect(json_body).to eql(error_404)
    end
  end
end
