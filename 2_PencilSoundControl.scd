(
"1_Load_AudioFiles.scd".loadRelative;
Server.default.boot;
Server.default.options.outDevice;
s.options.sampleRate_(44100);
s.options.memSize_(2.pow(20));
)
// b.choose.duration

// Blackhole (successor to Soundflower)


(
SynthDef(\buf_grainPencil, { |out, amp = 1, sndbuf, envbuf|


    var trig, pan, env, freqdev, dur, pos;

	var x = MouseX.kr(0, 1);
	var old = Delay1.kr(x);
	var delta = (x - old).abs;
	pos = Integrator.kr(delta, 1.0);

    // use mouse x to control panning
	trig = Impulse.ar(delta * 2000);
	pan = MouseX.kr(-1, 1);
	dur = MouseY.kr(1, 2) * 0.1 ; // interesting to play with

	env = EnvGen.kr(
        Env([0, 1, 0], [1, 1], \sin, 1),
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




// x = Synth(\buf_grainPencil, [\sndbuf, b, \envbuf, -1])


n = NetAddr("127.0.0.1", 57150);

n.sendMsg("/poem", "They think they are born in the best time,");
n.sendMsg("/poem", "Ignoring the existence of cruelty and poverty.");
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

