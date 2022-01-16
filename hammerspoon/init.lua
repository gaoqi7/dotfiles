hs.loadSpoon('Hyper')

Config = {}
Config.applications = require('configApplications')

Hyper = spoon.Hyper

Hyper:bindHotKeys({hyperKey = {{}, 'F18'}})

hs.fnutils.each(Config.applications, function(appConfig)
  if appConfig.hyperKey then
    Hyper:bind({}, appConfig.hyperKey, function() hs.application.launchOrFocusByBundleID(appConfig.bundleID) end)
  end
  if appConfig.localBindings then
    hs.fnutils.each(appConfig.localBindings, function(key)
      Hyper:bindPassThrough(key, appConfig.bundleID)
    end)
  end
end)



-- Random bindings
Hyper:bind({}, 'r', function()
    hs.application.launchOrFocusByBundleID('org.hammerspoon.Hammerspoon')
  end)
  Hyper:bind({'shift'}, 'r', function() hs.reload() end)




-- Windows Management
hs.loadSpoon('MoveWindows')
hs.loadSpoon('Split')
MoveWindows = spoon.MoveWindows
MoveWindows
  :start()
  :bind('', ',', function()
    hs.window.focusedWindow()
      :application()
      :selectMenuItem("Tile Window to Left of Screen")
    MoveWindows:exit()
  end)
  :bind('', '.', function()
    hs.window.focusedWindow()
      :application()
      :selectMenuItem("Tile Window to Right of Screen")
    MoveWindows:exit()
  end)
  :bind('', 'v', function()
    spoon.Split.split()
    MoveWindows:exit()
  end)
  :bind('', 'tab', function ()
    hs.window.focusedWindow():centerOnScreen()
    MoveWindows:exit()
  end)

Hyper:bind({}, 'm', function() MoveWindows:toggle() end)








  -- Application Specific Shortcut

function newModal(name, conditionEnter, conditionExit)
  local modal = hs.hotkey.modal.new()

  -- function modal:entered() hs.alert(string.format("Enter %s", name)) end
  -- function modal:exited() hs.alert(string.format("Exit %s", name)) end

  local appWatcherCallback =
    function(appName, eventType, appObject)
      if conditionEnter(appName, eventType, appObject) then
        modal:enter()
      elseif conditionExit(appName, eventType, appObject) then
        modal:exit()
      end
    end
  local watcher = hs.application.watcher.new(appWatcherCallback)
  watcher:start()

  return modal, watcher
end


function remap(modal, fromModifiers, fromKey, toModifiers, toKey)
  local pressFn = function()
    -- Unpress all current modifiers (e.g. so that application does not receive ctrl+return instead of just return)
    for _, currentModifier in ipairs(fromModifiers) do
      hs.eventtap.event.newKeyEvent(currentModifier, false):post()
    end 
    hs.eventtap.keyStroke(toModifiers, toKey, 0)
  end
  local repeatFn = function()
    hs.eventtap.keyStroke(toModifiers, toKey, 0)
  end
  modal:bind(fromModifiers, fromKey, --[[pressfn=]] pressFn, --[[releasefn]] nil, --[[repeatfn=]] repeatFn)
end

-- Chrome
chrome, chromeWatcher = newModal("chrome",
 -- conditionEnter
  function(appName, eventType, appObject)
    return appName == "Google Chrome" and eventType == hs.application.watcher.activated end,
 -- conditionExit
  function(appName, eventType, appObject)
    return appName == "Google Chrome" and eventType == hs.application.watcher.deactivated end)

-- tab switching
remap(chrome, {"cmd"}, "n", {"ctrl"}, "tab")
remap(chrome, {"cmd"}, "h", {"ctrl", "shift"}, "tab")
-- avoid accidentally creating bookmarks
chrome:bind({"cmd"}, "d", function() end)

-- Alacritty
alacritty, alacrittyWatcher = newModal("chrome",
 -- conditionEnter
  function(appName, eventType, appObject)
    return appName == "Alacritty" and eventType == hs.application.watcher.activated end,
 -- conditionExit
  function(appName, eventType, appObject)
    return appName == "Alacritty" and eventType == hs.application.watcher.deactivated end)

-- Alacritty Leader Key
remap(alacritty, {"cmd"}, "f18", {"ctrl"}, "b")
