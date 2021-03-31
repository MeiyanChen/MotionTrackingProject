//"4_OSC_Qualisis.scd".loadRelative;
"3_Synthdefs.scd".loadRelative;

(

// master score
Tdef(\loopSequence, {

	f = Bus.audio(s, 2);  //effect1
	g = Bus.audio(s, 2);  //effect2
	h = Bus.audio(s, 2);  //effect3
	i = Bus.audio(s, 2);  //effect4
	j = Bus.audio(s, 2);  //effect5


	~keepLooping = true;
	{~keepLooping}.while ({
		"loop1_1 change".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[0]]);
		(5.5*4*0.5).wait;
	});


	~effect1 = Synth(\effect1, [\in, f]);
	~keepLooping = true;
	{~keepLooping}.while ({
		"loop1_2 change ".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[1], \endvalue, 2, \mul, 0.05, \out, f]);
		(5.5*4*0.5).wait;
	});

	~keepLooping = true;
	{~keepLooping}.while ({
		"loop1_3 change".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[2], \endvalue, 1.5, \mul, 0.1, \out, f]);
		(5.5*4*0.5).wait;
	});

	~keepLooping = true;
	{~keepLooping}.while ({
		"loop2_change".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[3], \endvalue, 0.5,  \mul, 0.1, \out, f]);
		(10*4*0.5).wait;
	});

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////

	~effect1.free;
    ~effect2 = Synth(\effect2, [\in, g]);

   ~keepLooping = true;
		{~keepLooping}.while ({
		"loop3_1_g1 play 3 times and then change".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[4], \wet, 0.1,  \mul, 0.4,\out, g]);
		(8*4*0.5).wait;
	});

	  ~keepLooping = true;
		{~keepLooping}.while ({
		"loop3_1_g2 play 3 times and then change".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[4], \wet, 0.4,  \mul, 0.4,\out, g]);
		(8*4*0.5).wait;
	});

	 ~keepLooping = true;
		{~keepLooping}.while ({
		"loop3_1_g3 play 3 times and then change".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[4], \wet, 0.9,  \mul, 0.4, \out, g]);
		(10*4*0.5).wait;
	});

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	 ~effect2.free;
	 ~effect3 = Synth(\effect3, [\in, h]);

	~keepLooping = true;
	{~keepLooping}.while ({
		"loop3_2_h1 play 3 times and then change".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[5], \wet, 0.5,\mul, 0.4, \out, h, \c, 20, \d, 20]);
		(7*4*0.5).wait;
	});


	~keepLooping = true;
	{~keepLooping}.while ({
		"loop3_2_h2 play 3 times and then change".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[5], \wet, 0.2,\mul, 0.4, \out, h, \c, 20, \d, 20]);
		(7*4*0.5).wait;
	});

		~keepLooping = true;
	{~keepLooping}.while ({
		"loop3_2_h3 play 3 times and then change".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[5], \wet, 0.1, \mul, 0.4, \out, h, \c, 20, \d, 20]);
		(10*4*0.5).wait;
	});

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     ~effect3.free;
	 ~effect4 = Synth(\effect3, [\in, i]);
	~keepLooping = true;
		{~keepLooping}.while ({
		"loop3_3_i1 play 3 times and then change".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[6], \wet, 0.1, \delaytime, 10, \out, i, \c, 0.2, \d, 0.2]);
		(8.5*4*0.5).wait;
	});

		~keepLooping = true;
		{~keepLooping}.while ({
		"loop3_3_i2 play 3 times and then change".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[6], \wet, 0.05, \delaytime, 5, \out, i, \c, 0.2, \d, 0.2]);
		(8.5*4*0.5).wait;
	});

		~keepLooping = true;
		{~keepLooping}.while ({
		"loop3_3_i3 play 3 times and then change".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[6], \wet, 0.02, \delaytime, 1, \out, i, \c, 0.2, \d, 0.2]);
		(10.5*4*0.5).wait;
	});

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	 ~effect4.free;
	 ~effect5 = Synth(\effect3, [\in, j]);

	~keepLooping = true;
	{~keepLooping}.while ({
		"loop4_change".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[7], \wet, 0.05,\size, 1.0,\out, j]);
		(8*4*0.5).wait;
	});

		~keepLooping = true;
	{~keepLooping}.while ({
		"loop4_2times then change".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[7], \wet, 0.03,\size, 1.0, \out, j]);
		(9*4*0.5).wait;
	});


	~keepLooping = true;
	{~keepLooping}.while ({
		"loop5_change to end".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[8], \wet, 0.02,\size, 1.0,  \out, j]);
		(8*4*0.5).wait;
	});

	"end".postln;

});
)



Tdef(\loopSequence).play;
~keepLooping = false;
//change stem

Tdef(\loopSequence).stop;
/*
var sequence = Pseq([
	"Part A",
	"Part B",
	"Part C",
	"Part D"
]);

var stream = sequence.asStream;

var nextFunction = {
	"Go!".postln;
	stream.next.postln;
};



(


var sequence = Pseq([
	{"Start!".postln;},
	{x = ~loops[0].play},
	{x.stop; x = ~creep1.play},
	{x.stop; ~loops[1].play},
	{~creep2.play},
	{~loops[2].play},
	{~creep3.play},
	{~loops[3].play},
	{~creep4.play},
	{"End!".postln;}
]);

var stream = sequence.asStream;

var nextFunction = {
	"Go!".postln;
	stream.next.value;
};

var window = Window("Colors", 300@300);
var button = Button(window, 300@300);
button.string = "Go!";
button.action = {nextFunction.value;};

window.front;
)
*/
