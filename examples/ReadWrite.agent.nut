#require "PubNub.class.nut:1.1.0"

/******************** APPLICATION CODE ********************/
const PUBKEY = "pub-c-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
const SUBKEY = "sub-c-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx";

channelBase <- split(http.agenturl(), "/").pop();
lightLevelChannel <- channelBase + "-lightLevel";
ledStateChannel <- channelBase + "-ledState";

pubnub <- PubNub(PUBKEY, SUBKEY);

pubnub.subscribe([ledStateChannel], function(err, result, tt) {
    if(result != null && ledStateChannel in result) {
        try {
            local data = http.jsondecode(result[ledStateChannel]);
            if ("state" in data) {
                device.send("led", data["state"].tointeger());
            }
        } catch(ex) {
            server.log("Error - " + ex);
        }
    }
});

device.on("light", function(lightlevel) {
    pubnub.publish(lightLevelChannel, { light = lightlevel});
});
