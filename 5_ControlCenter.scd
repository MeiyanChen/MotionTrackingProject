ServerOptions.devices;
ServerOptions.outDevices;
Server.default.options.outDevice_("Built-in Output");




//writing sound

Tdef(\pencilFast).play;

Tdef(\poem).play;



~bgm.play;

Tdef(\poem).stop;
Tdef(\pencilFast).stop;



~bgm.stop;

s.record;
s.stop;
s.plotTree;


/*
//play background sound

Tdef(\loopSequence).play;

//order it
~keepLooping = false;