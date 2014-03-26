atom_feed language: 'en-US' do |feed|
  feed.title 'Cookbook Versions'
  feed.updated Time.now

  @cookbook_versions.each do |v|
    feed.entry(v, url: cookbook_version_url(v.cookbook.name, v.version)) do |entry|
      entry.title v.cookbook.name
      entry.license v.license
      entry.version v.version
    end
  end
end
