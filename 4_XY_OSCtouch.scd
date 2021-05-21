

(
var processing = NetAddr("127.0.0.1", 57150);

// \oben has to be a unique identifier for an OSCdef, does not need to reflect the labels name
OSCdef(\xy1, {|msg, time, addr, recvPort|

	var x = msg[2];
	var y = msg[1];
	// uncomment to dump OSC messages
	// msg.postln;

	/*
	(isWriting > 0.0).if ({
		[x, y].postln;
	});
	*/

	// takes absolute values of room coordinates and scales the values
	c.set(x);
	d.set(y);
	processing.sendMsg("/poemPosTouch", x, y);
	// e.set(isWriting);
	// x.set(\mdepth, msg[3].abs.linlin(0, 2000, 0, 16));

	/*
	// also use the angles
	x.set(\amp, msg[4].abs.linexp(0, 180, 0.05, 1));
	x.set(\pan, msg[5].abs.linlin(0, 180, -1, 1));
	x.set(\ffreq, msg[6].abs.linlin(0, 180, 200, 20000));
	*/

}, '/1/multixy1/1'); // 6DOF name here
)


OSCFunc.trace(true);
//  paper position





Tdef(\poem).play;

(
Tdef(\poem, { 1.do {
	    n = NetAddr("127.0.0.1", 57150);
	    n.sendMsg("/poem",  "They think".postln); //我们以为我们生活在最好的时代 35''
	    8.75.wait;
        n.sendMsg("/poem", "they are".postln);
	    8.75.wait;
        n.sendMsg("/poem", "born in".postln);
	    8.75.wait;
        n.sendMsg("/poem", "the best time,".postln);
		9.75.wait;
	    n.sendMsg("/poem",  "Ignoring".postln); //却看不到角落的残酷存在 37''
	    9.25.wait;
        n.sendMsg("/poem", "the existence of".postln);
	    9.25.wait;
        n.sendMsg("/poem", "cruelty".postln);
        9.25.wait;
	    n.sendMsg("/poem", "and poverty.".postln);
        13.25.wait;

        n.sendMsg("/poem", "They are".postln); //我们是自怜自艾 自恋自负 又自卑自信的矛盾体 52
		8.43.wait;
	    n.sendMsg("/poem",  "the paradox of".postln);
	    8.43.wait;
        n.sendMsg("/poem", "self-pitying".postln);
	    8.43.wait;
        n.sendMsg("/poem", "resentment,".postln);
	    8.43.wait;
        n.sendMsg("/poem", "self-centeredness,".postln);
		8.43.wait;
	    n.sendMsg("/poem",  "self-abasement,".postln);
	    8.43.wait;
        n.sendMsg("/poem", "self-confidence,".postln);
	    10.43.wait;
        n.sendMsg("/poem", "Omitting".postln); //却看不到对他人的理解与同情心  36
	    10.wait;
        n.sendMsg("/poem", "the essence of,".postln);
		10.wait;
        n.sendMsg("/poem", "sympathy".postln);
	    10.wait;
	    n.sendMsg("/poem", "and empathy.".postln);   //+5
	    11.wait;
 /*
        n.sendMsg("/poem", "As if"); //每个人都希望拥有幸福 30
		7.wait;
	    n.sendMsg("/poem",  "happiness");
	    7.wait;
        n.sendMsg("/poem", "belongs to");
	    7.wait;
        n.sendMsg("/poem", "each and every one");
	    7.wait;
        n.sendMsg("/poem", "expectantly,");
		7.wait;
	    n.sendMsg("/poem",  "though"); //有些人却不想付出相应的辛苦 36
	    7.wait;
        n.sendMsg("/poem", "they do not");
	    7.wait;
        n.sendMsg("/poem", "toil for it.");
	    7.wait;
*/
        n.sendMsg("/poem", "Id like to".postln); //我习惯嘲笑一些事情的存在 36
		12.wait;
	    n.sendMsg("/poem",  "laugh at".postln);
	    12.wait;
        n.sendMsg("/poem", "such things,".postln);
	    12.wait;
        n.sendMsg("/poem", "but I sigh".postln); //却无奈叹息 无力独自改变所有狭隘  40
	    10.wait;
        n.sendMsg("/poem", "helplessly".postln);
		10.wait;
	    n.sendMsg("/poem",  "at my inability".postln);
	    10.wait;
        n.sendMsg("/poem", "to change".postln);
	    10.wait;
        n.sendMsg("/poem", "the parochialism.".postln); //+5
	    11.wait;


        n.sendMsg("/poem", "If the color of".postln); //海水的颜色取决于天空的颜色 35
		9.75.wait;
	    n.sendMsg("/poem",  "the ocean".postln);
	    9.75.wait;
        n.sendMsg("/poem", "rely on that".postln);
	    9.75.wait;
        n.sendMsg("/poem", "in the sky,".postln);
	    9.75.wait;
        n.sendMsg("/poem", "then".postln);  //眼睛的颜色取决于土地的颜色 39
		9.75.wait;
	    n.sendMsg("/poem",  "the eyes color".postln);
	    9.75.wait;
        n.sendMsg("/poem", "reflect that".postln);
	    9.75.wait;
        n.sendMsg("/poem", "of the land.".postln);
	    9.75.wait;

        n.sendMsg("/poem", "If there is".postln); //没有边界 没有信仰 是否得以成全 38
		7.6.wait;
	    n.sendMsg("/poem",  "no border,".postln);
	    7.6.wait;
        n.sendMsg("/poem", "no belief,".postln);
	    7.6.wait;
        n.sendMsg("/poem", "can it".postln);
	    7.6.wait;
        n.sendMsg("/poem", "be fulfilled?".postln);
		8.6.wait;

	    n.sendMsg("/poem", "If there is".postln); //没有颜色 没有光彩 是否就没有黑与白 40
		7.5.wait;
	    n.sendMsg("/poem", "no light,".postln);
	    7.5.wait;
        n.sendMsg("/poem", "no color,".postln);
	    7.5.wait;
        n.sendMsg("/poem", "is there".postln);
	    7.5.wait;
        n.sendMsg("/poem", "no black?".postln);
		7.5.wait;
	    n.sendMsg("/poem", "and white?".postln);  //+5
		8.5.wait;


/*

        n.sendMsg("/poem", "I’d like to"); //我习惯思考一些事情的存在 28
		7.wait;
	    n.sendMsg("/poem",  "ponder");
	    10.wait;
        n.sendMsg("/poem", "such things,");
	    10.wait;
        n.sendMsg("/poem", "yet thinking"); //却也知晓 思考也许不足以改变所有的狭隘 45
	    10.wait;
        n.sendMsg("/poem", "isn't enough");
		10.wait;
	    n.sendMsg("/poem", "to change");
	    10.wait;
	    n.sendMsg("/poem",  "though "); //但 思考 连接了世界 与我 26
	    10.wait;
        n.sendMsg("/poem",  "it is");
	    10.wait;
        n.sendMsg("/poem", " the only");
	    10.wait;
	    n.sendMsg("/poem",  "connection");
	    10.wait;
	    n.sendMsg("/poem",  "between you");
	    10.wait;
	    n.sendMsg("/poem",  "and me."); //+5
	    10.wait;


        n.sendMsg("/poem", "If the color of"); //海水的颜色取决于天空的颜色 34
		10.wait;
	    n.sendMsg("/poem",  "the ocean");
	    10.wait;
        n.sendMsg("/poem", "rely on that");
	    10.wait;
        n.sendMsg("/poem", "in the sky,");
	    10.wait;
        n.sendMsg("/poem", "then");  //眼睛的颜色取决于土地的颜色 40
		10.wait;
	    n.sendMsg("/poem",  "the eyes’ color");
	    10.wait;
        n.sendMsg("/poem", "reflect that");
	    10.wait;
        n.sendMsg("/poem", "of the land.");
	    10.wait;
*/
        n.sendMsg("/poem", "If there is".postln); //没有得到 没有失去 是否还有感知 33
		6.6.wait;
	    n.sendMsg("/poem",  "no gain,".postln);
	    6.6.wait;
        n.sendMsg("/poem", "no loss,".postln);
	    6.6.wait;
        n.sendMsg("/poem", "can it".postln);
	    6.6.wait;
        n.sendMsg("/poem", "be felt?".postln);
		6.6.wait;

	    n.sendMsg("/poem", "If there is".postln); //没有黑夜 没有光明 是否还能感知生命 42
		8.4.wait;
	    n.sendMsg("/poem",  "no darkness,".postln);
	    8.4.wait;
        n.sendMsg("/poem", "no light, ".postln);
	    8.4.wait;
        n.sendMsg("/poem", "can it ".postln);
	    8.4.wait;
        n.sendMsg("/poem", "be alive?".postln);
		8.4.wait;
	}});
)
