(
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

)

(
SynthDef(\buffer4, { |out, bufnum, start, time, amp, rate = 1|
	var sig = PlayBuf.ar(2, bufnum,
		rate: rate * BufRateScale.kr(bufnum),
		startPos: start, loop: 0
	),
	env = EnvGen.kr(Env.linen(0.01, time, 0.01, level: amp),
		doneAction: Done.freeSelf);
	Out.ar(out, (sig * env*SinOsc.ar(In.kr(d).linlin(0, 1, 400,800))));
}).add;
)

(
{
var start = 0, end = 13,
beatsInLoop = 8,
originalTempo = beatsInLoop / (end - start);

TempoClock.tempo = originalTempo;

~creep1 = Pbind(
	\instrument, \buffer4,
	\bufnum, ~loops[1],
	\amp, 0.5,
	\start, start * ~loops[1].sampleRate,
	\dur, beatsInLoop,
	\time, Pkey(\dur) / Pfunc { thisThread.clock.tempo },
	\rate, Pfunc { thisThread.clock.tempo / originalTempo }
);
}
)


~creep1.play