"1_Load_AudioFiles.scd".loadRelative;


// b.choose.duration


(
SynthDef(\buf_grainPencil, { |out, gate = 1, amp = 1, sndbuf, envbuf|


    var trig, pan, env, freqdev, dur, pos;

	var x = MouseX.kr(0, 1);
	var old = Delay1.kr(x);
	var delta = (x - old).abs;
	pos = Integrator.kr(delta, 1.0);

    // use mouse x to control panning
	trig = Impulse.ar(delta * 2000);
	pan = MouseX.kr(-1, 1);
	dur = MouseY.kr(1, 2) * 0.3 ;
	env = EnvGen.kr(
        Env([0, 1, 0], [1, 1], \sin, 1),
        gate,
        levelScale: amp,
        doneAction: Done.freeSelf);
    Out.ar(out,
        GrainBuf.ar(2, trig, dur, sndbuf, LFNoise1.kr.range(0.5, 2),  pos, 2, pan, envbuf)* env)
}).add;
)

(
Tdef(\pencilFast, {
	inf.do {
		var sndbuf = ~pencilwriting.choose;
		Synth(\buf_grainPencil, [\sndbuf, sndbuf, \envbuf, -1]);
		sndbuf.duration.wait;
	}
});
)



Tdef(\pencilFast).play;
Tdef(\pencilFast).stop;

s.scope




// x = Synth(\buf_grainPencil, [\sndbuf, b, \envbuf, -1])

