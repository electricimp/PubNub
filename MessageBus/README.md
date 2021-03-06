# PubNub

The [MessageBus class](./MessageBus.class.nut) uses the PubNub API to create seamless device to device communication (through their agents and PubNub).

### Contributors ###

- Matt Haines

## Usage ##

### Instantiate PubNub and MessageBus objects ###

```squirrel
pubNub <- PubNub(publishKey, subscribeKey);
messageBus <- MessageBus(pubNub);
```

### Broadcast a Message ###

To send data to another device (or devices) use the MessageBus.send() function. This function is syntatically idential to [**agent.send()**](https://developer.electricimp.com/api/agent/send), but broadcasts the message to all agents listening on the PubNub stream.

```squirrel
messageBus.send("messageName", data);
```

### Listen for Messages ###

To listen for a particular message from another device, use the MessageBus.on() function. This function is syntatically identical to [agent.on](https://developer.electricimp.com/api/agent/on), but listends for messages from other agents broadcasting on the PubNub stream.

```squirrel
messageBus.on("messageName", function(data) {
  // Do something with the data
  server.log(data);
});
```

### Listen for a Message from a Specific Device ###

If you are interested in listening for and reacting to messages from a particular device in the stream, you can use the MessageBus.onDevice() function. The onDevice function works similar to the *.on()* function, but includes an additional parameter of UUID &mdash; which can be set in the PubNub constructor (and is the last part of the agentURL by default).

```squirrel
messageBus.onDevice("9Liw5_TVUzcU", "messageName", function(data) {
  // Do something with the data from the device with UUID: 9Liw5_TVUzcU
  server.log(data);
});
```
