"1_Load_AudioFiles.scd".loadRelative;

(
c = [
~loops[0],
~loops[1],
~loops[2],
~loops[3],
~loops[4],
~loops[5],
~loops[6],
~loops[7],
~loops[8]

];
)

(

(
SynthDef(\bufferPlayer, {|buffer=0, out=0|
	var sig = PlayBuf.ar(2, buffer, doneAction:2);
	Out.ar(out, sig);
}).add;


SynthDef(\effect1, {|in, out|
	var sig = In.ar(in, 2);
	sig = sig * SinOsc.ar(400, 0, MouseX.kr(0, 1));
	Out.ar(out, sig);
}).add;


SynthDef(\effect2, {|in, out|
	var sig = In.ar(in, 2);
	sig = sig * SinOsc.ar(MouseY.kr(200, 700), 0, MouseX.kr(0, 1));
	Out.ar(out, sig);
}).add;

);


(
f = Bus.audio(s, 2);
Synth(\effect2, [\in, f]);
~which = 0;
);
)

(
Pbind(
	\instrument, \bufferPlayer,
	\buffer, Pindex(c, Pfunc({~which}), inf),
	\out, f,
	\dur, 12,
).play;
)

s.plotTree