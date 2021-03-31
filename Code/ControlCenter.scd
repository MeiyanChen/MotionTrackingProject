ServerOptions.devices;
ServerOptions.outDevices;
Server.default.options.outDevice_("Built-in Output");

//play background sound

Tdef(\loopSequence).play;

//order it
~keepLooping = false;


s.record;
s.stop;
s.plotTree;

//writing sound
Tdef(\pencilFast).play;

Tdef(\pencilFast).stop;
// change poem

n = NetAddr("127.0.0.1", 57150);

n.sendMsg("/poem", "They think they are born");
n.sendMsg("/poem", "in the best time,");
n.sendMsg("/poem", "Ignoring the existence");
n.sendMsg("/poem", "of cruelty and poverty.");
n.sendMsg("/poem", "They are the paradox of");
n.sendMsg("/poem", "self-pitying resentment,");
n.sendMsg("/poem", "self-centeredness,");
n.sendMsg("/poem", "self-abasement,");
n.sendMsg("/poem", "self-confidence,");
n.sendMsg("/poem", "Omitting the essence of sympathy and empathy");
n.sendMsg("/poem", "As if happiness belongs to each and every one
expectantly,");
n.sendMsg("/poem", "though they do not toil for it.");
n.sendMsg("/poem", "I’d like to laugh at such things,");
n.sendMsg("/poem", "but I sigh helplessly at my inability");
n.sendMsg("/poem", "to change the parochialism.");
n.sendMsg("/poem", "");
