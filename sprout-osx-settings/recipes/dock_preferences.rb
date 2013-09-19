if node['dock_preferences']['orientation']
  osx_defaults "set dock to be on #{node['dock_preferences']['orientation']}" do
    domain 'com.apple.dock'
    key 'orientation'
    string node['dock_preferences']['orientation']
  end
end

osx_defaults 'set dock to autohide' do
  domain 'com.apple.dock'
  key 'autohide'
  boolean node['dock_preferences']['autohide'] && node['dock_preferences']['autohide'] != 'false'
end

if node['dock_preferences']['clear_apps']
  osx_defaults 'remove persistent apps from the dock' do
    domain 'com.apple.dock'
    key 'persistent-apps'
    array []
  end
end

if node['dock_preferences']['tilesize']
  osx_defaults "adjusts dock size to #{node['dock_preferences']['tilesize']}" do
    domain 'com.apple.dock'
    key 'tilesize'
    integer node['dock_preferences']['tilesize']
  end
end

execute 'relaunch dock' do
  command 'killall Dock'
end
