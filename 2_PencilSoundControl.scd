"Load_AudioFiles.scd".loadRelative;


(
b = [
	~pencilwriting[0], //Mono Quick
	~pencilwriting[1], //Mono Quick
	~pencilwriting[2], //Mono Quick
	~pencilwriting[3] //Mono Quick
    ]

)

b.choose.duration


(
SynthDef(\buf_grainPencil, { |out, gate = 1, amp = 1, sndbuf, envbuf|
    var trig, pan, env, freqdev,dur;
    // use mouse x to control panning
    trig =MouseX.kr(0, 1);
	pan = MouseX.kr(-1, 1);
	dur = MouseY.kr(1, 2);
	env = EnvGen.kr(
        Env([0, 1, 0], [1, 1], \sin, 1),
        gate,
        levelScale: amp,
        doneAction: Done.freeSelf);
    Out.ar(out,
        GrainBuf.ar(2, trig, dur, sndbuf, LFNoise1.kr.range(0.5, 2),  LFNoise2.kr(0.1).range(0, 1), 2, pan, envbuf)* env)
}).add;
)

(
Tdef(\pencilFast, {
	inf.do {
		var sndbuf = b.choose;
	Synth(\buf_grainPencil, [\sndbuf, b, \envbuf, -1]);
		sndbuf.duration.wait;
	}
});
)



Tdef(\pencilFast).play;
Tdef(\pencilFast).stop;

// most funnest Ugens in SuperCollider!
GrainBuf

s.boot;




x = Synth(\buf_grainPencil, [\sndbuf, b, \envbuf, -1])

