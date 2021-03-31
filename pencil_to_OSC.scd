(
"1_Load_AudioFiles.scd".loadRelative;
Server.default.boot;
Server.default.options.outDevice;
s.options.sampleRate_(44100);
s.options.memSize_(2.pow(20));
)
// b.choose.duration

// Blackhole (successor to Soundflower)
( // create Control Busses
c = Bus.control(s, 1); // X from 0 to 1
d = Bus.control(s, 1); // Y from 0 to 1
e = Bus.control(s, 1); // Writing (1) or not Writing (0)
)

(
SynthDef(\buf_grainPencil, { |out, amp = 1, sndbuf, envbuf|


    var trig, pan, env, freqdev, dur, pos;

	var x = In.kr(c, 1);
	var old = Delay1.kr(x);
	var delta = (x - old).abs;
	pos = Integrator.kr(delta, 1.0);

    // use mouse x to control panning
	trig = Impulse.ar(delta * 2000) * MouseButton.kr(0, 1);
	pan = In.kr(c, 1);
	dur = In.kr(d, 1) * 0.1 ; // interesting to play with

	env = EnvGen.kr(
        Env([0, 1, 0], [1, 1], \sin),
        levelScale: amp,
        doneAction: Done.freeSelf);

    Out.ar(out,
		GrainBuf.ar(2, trig, dur, sndbuf, LFNoise1.kr.range(0.5, 2),  pos.clip, 2, pan, envbuf)* env)
}).add;
)

(
Tdef(\pencilFast, {
	inf.do {
		var sndbuf = ~pencilwriting.choose;
		Synth(\buf_grainPencil, [\sndbuf, sndbuf, \envbuf, -1]);
		1.wait;
	}
});
)


Tdef(\pencilFast).play;
Tdef(\pencilFast).stop;
