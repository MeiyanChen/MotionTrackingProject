//Sound Settings
"Load_AudioFiles.scd".loadRelative;
 // create Control Busses
c = Bus.control(s, 1); // X from 0 to 1
d = Bus.control(s, 1); // Y from 0 to 1
e = Bus.control(s, 1); // Writing (1) or not Writing (0)




//c.set(0.5);

 // send MouseX/MouseY to control busses
{
	Out.kr(c, MouseX.kr(0, 1));
	Out.kr(d, MouseY.kr(0, 1));
}.value;


// Pencil Sound / writing -----------------------------------


Ndef(\writing,
	{ arg out=0, bufnum=0;
		var amp = In.kr(e, 1);
		var trig = Impulse.ar(4, [0, In.kr(c, 1)], 0.2);
		Out.ar(out,
			PlayBuf.ar(2,~material2[0], amp * BufRateScale.kr(~material2[0]), trig, In.kr(d, 1).linlin(0, 1, 0, BufFrames.kr(~material2[0])), 1)
		)
	}
);

//Ndef(\writing).play


// SynthDefs

//b = ~material1[2];  // change stems here

SynthDef(\buffer1, { |out, bufnum, start, trig, time, amp, rate = 1|
	var sig = PlayBuf.ar(2, bufnum,
		rate: rate * BufRateScale.kr(bufnum),
		startPos: start, loop: 0
	),
	env = EnvGen.kr(Env.linen(0.01, time, 0.03, level: amp),
		doneAction: Done.freeSelf);
	Out.ar(out, (sig * env).dup);
}).add;

SynthDef(\buffer2, { |out, bufnum, start, time, amp, rate = 1|
	var sig = PlayBuf.ar(2, bufnum,
		rate: rate * BufRateScale.kr(bufnum),
		startPos: start, loop: 0
	),
	env = EnvGen.kr(Env.perc(0.01, time, 0.05, level: amp),
		doneAction: Done.freeSelf);
	Out.ar(out, (sig * env).dup);
}).add;

SynthDef(\buffer3, { |out, bufnum, start, time, amp, rate = 1|
	var sig = PlayBuf.ar(2, bufnum,
		rate: rate * BufRateScale.kr(bufnum),
		startPos: start, loop: 0
	),
	env = EnvGen.kr(Env.linen(0.05, time, 0.05, level: amp),
		doneAction: Done.freeSelf);
	Out.ar(out, (sig * env*SinOsc.ar(In.kr(c),linlin(0, 1, 20, 5000))));
}).add;

SynthDef(\buffer4, { |out, bufnum, start, time, amp, rate = 1|
	var sig = PlayBuf.ar(2, bufnum,
		rate: rate * BufRateScale.kr(bufnum),
		startPos: start, loop: 0
	),
	env = EnvGen.kr(Env.linen(0.01, time, 0.01, level: amp),
		doneAction: Done.freeSelf);
	Out.ar(out, (sig * env*SinOsc.ar(In.kr(d).linlin(0, 1, 400,800))));
}).add;


SynthDef(\buffer5, { |out, bufnum, start, trig, time, amp, rate = 1|
	var sig = PlayBuf.ar(2, bufnum,
		rate: rate * BufRateScale.kr(bufnum),
		startPos: start, loop: 0
	),
	env = EnvGen.kr(Env.linen(0.01, time, 0.06, level: amp),
		doneAction: Done.freeSelf);
	Out.ar(out, (sig * env * {     var vib = BRF.kr(SinOsc.kr([1, 3, 10], 0, [1, 0.5, 0.25]).sum, In.kr(c, 1), 0.3);
		SinOsc.ar(vib * 200 + 600) * 0.2 }).dup);
}).add;



// check the original stem here
// b.play;



//phasing/ looping one of the stems we choose from the synthdef ´buffer1-4
{
var start = 0, end = 13,
beatsInLoop = 8,
originalTempo = beatsInLoop / (end - start);

TempoClock.tempo = originalTempo;

~creep1 = Pbind(
	\instrument, \buffer4,
	\bufnum, ~material1[0],
	\amp, 0.5,
	\start, start * ~material1[0].sampleRate,
	\dur, beatsInLoop,
	\time, Pkey(\dur) / Pfunc { thisThread.clock.tempo },
	\rate, Pfunc { thisThread.clock.tempo / originalTempo }
) /* .value(quant: [8, 4]); */

~creep2 = Pn( Pfindur(8,
	Pbind(
		\instrument, \buffer2,
		\bufnum, ~material1[1],
		\amp, 0.2,
		\start, start * ~material1[1].sampleRate,
		\dur, beatsInLoop,
		\time, Pkey(\dur) / Pfunc { thisThread.clock.tempo },
		\rate, Pfunc { thisThread.clock.tempo / originalTempo }
),inf) /* .value(quant: [8, 4]); */

~creep3 = Pbind(
	\instrument, \buffer3,
	\bufnum, ~material1[2],
	\amp, 0.2,
	\start, start * ~material1[2].sampleRate,
	\dur, beatsInLoop,
	\time, Pkey(\dur) / Pfunc { thisThread.clock.tempo },
	\rate, Pfunc { thisThread.clock.tempo / originalTempo }
) /* .value(quant: [4, 3.5]) */;

~creep4 = Pn(
	Pfindur(
		8,
		Pbind(
			\instrument, \buffer4,
			\bufnum, ~material1[3],
			\amp, 0.4,
			\start, start * ~material1[3].sampleRate,
			\dur, beatsInLoop,
			\time, Pkey(\dur) / Pfunc { thisThread.clock.tempo },
			\rate, Pfunc { thisThread.clock.tempo / originalTempo }
		),
		inf
	) /* .value(quant: [4, 2]) */;
))
}.value;



p.play;
~creep3.play;


// another effect to use synthdef
{
	var start = 0, end = 13,
beatsInLoop = 4,
originalTempo = beatsInLoop / (end - start);

TempoClock.tempo = originalTempo;

~effect1 = Pbind(
	\instrument, \buffer4,
	\bufnum, ~material1[2],
	\amp, 0.8,
	\sustain, 10,
	\legato, 5,
	\timeOffset, Pseq([0, 1.5, 3], inf),
	\start, start * ~material1[2].sampleRate,
	\dur, beatsInLoop,
	\time, Pkey(\dur) / Pfunc { thisThread.clock.tempo },
	\rate, Pfunc { thisThread.clock.tempo / originalTempo }
);

}.value;




x.free;

// the end
{
x = { var src;
	src = PlayBuf.ar(2, ~material1[7], 1, (Impulse.kr(XLine.kr(0.1, 400, 30))));
	Splay.ar(src,In.kr(d, 1), 0.2, In.kr(d, 1));
}.play;
}.value;