# Bindable Event Wrapper

A BindableEventWrapper is an object that wraps a [BindableEvent](https://create.roblox.com/docs/reference/engine/classes/BindableEvent) and provides an API similar to that of normal signal libraries.

## Usage

To use this, simply create a new instance by calling new. Afterwards, use the created instance like an [RBXScriptSignal](https://create.roblox.com/docs/reference/engine/datatypes/RBXScriptSignal). Unlike an RBXScriptSignal, there is a [Fire](https://blru.github.io/roblox-bindable-event-wrapper/api/BindableEventWrapper#Fire) method to fire the event.

```lua
local BindableEventWrapper = require(Path.To.Module)

local foodConsumed = BindableEventWrapper.new()

foodConsumed:Connect(function(consumer: Player, kind: string)
    print(consumer.Name .. " ate a " .. kind .. ".")
end)

foodConsumed:Fire(someone, "carrot")
```

For more information, refer to the [**documentation**](http://blru.github.io/roblox-bindable-event-wrapper/api/BindableEventWrapper).

## Why use this?

Uh..

> "Your scientists were so preoccupied with whether or not they could, they didn't stop to think if they should."

Realistically, it is oftentimes better to use an actual signal implementation, such as [RbxUtil's Signal](https://sleitnick.github.io/RbxUtil/api/Signal) or [FastSignal](https://github.com/RBLXUtils/FastSignal), especially if you want to get around the [limitations](https://create.roblox.com/docs/scripting/events/bindable#argument-limitations) imposed by traditional BindableEvents.
