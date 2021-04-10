"1_Load_AudioFiles.scd".loadRelative;

( // create Control Busses
c = Bus.control(s, 1); // X from 0 to 1
d = Bus.control(s, 1); // Y from 0 to 1
e = Bus.control(s, 1); // Writing (1) or not Writing (0)
)

( // send MouseX/MouseY to control busses
{
	Out.kr(c, MouseX.kr(0, 1));
	Out.kr(d, MouseY.kr(0, 1));
}.play;
)


(
SynthDef(\bufferPlayer, {|buffer=0, out=0|
	var sig = PlayBuf.ar(2, buffer, doneAction:2);
	Out.ar(out, sig * 0.5);
}).add;

SynthDef(\effect1, {|in, out, freq = 400, endvalue = 20, amp = 0.5|
	var source = In.ar(in, 2);
	var line = Line.kr(0, 1, endvalue);
	var fx = source * SinOsc.ar(freq, In.kr(d, 1), In.kr(c, 1));
	Out.ar(out, (source * (1.0-line)) + (fx * line) * amp);
}).add;



SynthDef(\effect2, {|in, out, wet = 0.9, amp = 0.1|
	var drySignal, wetSignal, vib;
	drySignal = In.ar(in, 2);
	vib = BPF.ar(drySignal, In.kr(c, 1).linexp(0, 1, 1, 100), amp);
	wetSignal = drySignal * vib * 0.2;
	Out.ar(out, (drySignal *(1.0 - wet)) + (wetSignal *wet));
}).add;



SynthDef(\effect3, { |in, out,wet = 0.3,  amp = 0.1|
	var drySignal, wetSignal, ctl;
	drySignal = In.ar(in, 2);
	ctl = HPF.ar(drySignal, In.kr(c, 1).linexp(0, 1, 2,200), amp) * 2;
	wetSignal = drySignal * ctl;
    Out.ar(out, (drySignal *(1.0 - wet)) + (wetSignal *wet));
}).add;


SynthDef(\effect4, {|in, out,wet = 0.5,  decaytime = 15,  mul = 0.5|
	var drySignal, wetSignal, delay;
	drySignal = In.ar(in, 2);
	delay = CombN.ar( drySignal, In.kr(c, 1), In.kr(d, 1), decaytime, mul);
	wetSignal = drySignal + delay;
    Out.ar(out, (drySignal *(1.0 - wet)) + (wetSignal *wet));
}).add;


 //delaytime higher, effects more

SynthDef(\effect5, { |in, out, wet = 0.9, size = 3|
	var drySignal, wetSignal, rev;
	drySignal = In.ar(in, 2);
	rev = JPverb.ar(drySignal,1, In.kr(c, 1), In.kr(d, 1));
	wetSignal = drySignal + rev;
    Out.ar(out, (drySignal *(1.0 - wet)) + (wetSignal *wet));
}).add;
)

/*

(
f = Bus.audio(s, 2);
Synth(\effect2, [\in, f]);
~which = 0;
);
)

(
Pbind(
	\instrument, \bufferPlayer,
	\buffer, Pindex([\Loops].bufnum, Pfunc({~which}), inf),
	\out, f,
	\dur, 12,
).play;
)
*/

