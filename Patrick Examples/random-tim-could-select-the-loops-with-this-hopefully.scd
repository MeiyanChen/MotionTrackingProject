(
b = [
	"C:/Users/patri/Documents/src/MotionTrackingProject/Audio/Loops/Loop1_1.aif",
	"C:/Users/patri/Documents/src/MotionTrackingProject/Audio/Loops/Loop1_2.aif",
	"C:/Users/patri/Documents/src/MotionTrackingProject/Audio/Loops/Loop1_3.aif",
];
)

b = b.collect {|path| Buffer.read(s, path)};


(
SynthDef(\bufferPlayer, {|buffer=0, out=0|
	var sig = PlayBuf.ar(2, buffer, doneAction:2);
	Out.ar(out, sig);
}).add;
)

(
SynthDef(\effect, {|in, out|
	var sig = In.ar(in, 2);
	sig = sig * SinOsc.ar(100);
	Out.ar(out, sig);
}).add;
)

f = Bus.audio(s, 2);
Synth(\effect, [\in, f]);


~which = 0;

(
Pbind(
	\instrument, \bufferPlayer,
	\buffer, Pindex(b, Pfunc({~which}), inf),
	\out, f,
	\dur, 12,
).play;
)

s.plotTree


