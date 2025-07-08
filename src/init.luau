--[=[
    @class BindableEventWrapper

    A wrapper around a [BindableEvent] that exposes a similar API to that of a normal signal library.

    Please note that this has the same [limitations](https://create.roblox.com/docs/scripting/events/bindable#argument-limitations) as a regular BindableEvent.

    ```lua
    local roundEnded = BindableEventWrapper.new()

    foodEaten:Connect(function(winner)
        print(winner .. " won the round!")
    end)

    foodEaten:Fire("Jerry")
    ```
]=]
local BindableEventWrapper = {}
BindableEventWrapper.__index = BindableEventWrapper

type BindableEventWrapper = typeof(setmetatable({} :: {}, BindableEventWrapper))

--[=[
    @prop _internal BindableEvent
    @private
    @within BindableEventWrapper

    The underlying bindable event used by the class
]=]

--[=[
    @within BindableEventWrapper
    @param event BindableEvent? -- If this is not nil, the wrapper will wrap the provided [BindableEvent] instead of creating a new one.

    Instantiates a new BindableEventWrapper.
]=]
function BindableEventWrapper.new(event: BindableEvent?)
	assert(
		event == nil
			or (typeof(event) == "Instance" and event:IsA("BindableEvent")),
		"event must be nil or an instance of BindableEvent"
	)

	if event == nil then
		event = Instance.new("BindableEvent")
	end

	local self = {
		_inner = event,
	}

	setmetatable(self, BindableEventWrapper)

	return self
end

--[=[
    @within BindableEventWrapper

    Fires the internal [BindableEvent].

    See [BindableEvent:Fire]
]=]
function BindableEventWrapper.Fire(self: BindableEventWrapper, ...: any)
	self._inner:Fire(...)
end

--[=[
    @within BindableEventWrapper

    Connects to the internal [BindableEvent's Event](https://create.roblox.com/docs/reference/engine/classes/BindableEvent#Event) and returns the [RBXScriptConnection](https://create.roblox.com/docs/reference/engine/datatypes/RBXScriptConnection) representing it.

    See [RBXScriptSignal:Connect]
]=]
function BindableEventWrapper.Connect(
	self: BindableEventWrapper,
	callback: (...any) -> ()
): RBXScriptConnection
	return self._inner.Event:Connect(callback)
end

--[=[
    @within BindableEventWrapper

    See [RBXScriptSignal:ConnectParallel]
]=]
function BindableEventWrapper.ConnectParallel(
	self: BindableEventWrapper,
	callback: (...any) -> ()
): RBXScriptConnection
	return self._inner.Event:ConnectParallel(callback)
end

--[=[
    @within BindableEventWrapper

    Connects to the [internal BindableEvent's Event](https://create.roblox.com/docs/reference/engine/classes/BindableEvent#Event) such that the connection is disconnected after the first event is delivered. Returns the [RBXScriptConnection](https://create.roblox.com/docs/reference/engine/datatypes/RBXScriptConnection) representing the connection.

    See [RBXScriptSignal:Once]
]=]
function BindableEventWrapper.Once(
	self: BindableEventWrapper,
	callback: (...any) -> ()
): RBXScriptConnection
	return self._inner.Event:Once(callback)
end

--[=[
    @within BindableEventWrapper
    @yields

    Yields until the internal [BindableEvent's Event](https://create.roblox.com/docs/reference/engine/classes/BindableEvent#Event) fires. Returns the arguments provided by the signal.

    See [RBXScriptSignal:Wait]
]=]
function BindableEventWrapper.Wait(self: BindableEventWrapper): ...any
	return self._inner.Event:Wait()
end

return BindableEventWrapper
