

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
	    n.sendMsg("/poem",  "They think"); //我们以为我们生活在最好的时代 35''
	    8.75.wait;
        n.sendMsg("/poem", "they are");
	    8.75.wait;
        n.sendMsg("/poem", "born in");
	    8.75.wait;
        n.sendMsg("/poem", "the best time,");
		8.75.wait;
	    n.sendMsg("/poem",  "Ignoring"); //却看不到角落的残酷存在 37''
	    9.25.wait;
        n.sendMsg("/poem", "the existence of");
	    9.25.wait;
        n.sendMsg("/poem", "cruelty");
        9.25.wait;
	    n.sendMsg("/poem", "and poverty.");
        9.25.wait;

        n.sendMsg("/poem", "They are"); //我们是自怜自艾 自恋自负 又自卑自信的矛盾体 52
		7.43.wait;
	    n.sendMsg("/poem",  "the paradox of");
	    7.43.wait;
        n.sendMsg("/poem", "self-pitying");
	    7.43.wait;
        n.sendMsg("/poem", "resentment,");
	    7.43.wait;
        n.sendMsg("/poem", "self-centeredness,");
		7.43.wait;
	    n.sendMsg("/poem",  "self-abasement,");
	    7.43.wait;
        n.sendMsg("/poem", "self-confidence,");
	    7.43.wait;
        n.sendMsg("/poem", "Omitting"); //却看不到对他人的理解与同情心  36
	    6.8.wait;
        n.sendMsg("/poem", "the essence of,");
		6.8.wait;
	    n.sendMsg("/poem",  "Ignoring");
	    6.8.wait;
        n.sendMsg("/poem", "the existence of");
	    6.8.wait;
        n.sendMsg("/poem", "sympathy");
	    6.8.wait;
	    n.sendMsg("/poem", "and empathy.");   //+5
	    6.8.wait;
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
        n.sendMsg("/poem", "I’d like to"); //我习惯嘲笑一些事情的存在 36
		12.wait;
	    n.sendMsg("/poem",  "laugh at");
	    12.wait;
        n.sendMsg("/poem", "such things,");
	    12.wait;
        n.sendMsg("/poem", "but I sigh"); //却无奈叹息 无力独自改变所有狭隘  40
	    9.wait;
        n.sendMsg("/poem", "helplessly");
		9.wait;
	    n.sendMsg("/poem",  "at my inability");
	    9.wait;
        n.sendMsg("/poem", "to change");
	    9.wait;
        n.sendMsg("/poem", "the parochialism."); //+5
	    9.wait;


        n.sendMsg("/poem", "If the color of"); //海水的颜色取决于天空的颜色 35
		8.75.wait;
	    n.sendMsg("/poem",  "the ocean");
	    8.75.wait;
        n.sendMsg("/poem", "rely on that");
	    8.75.wait;
        n.sendMsg("/poem", "in the sky,");
	    8.75.wait;
        n.sendMsg("/poem", "then");  //眼睛的颜色取决于土地的颜色 39
		9.75.wait;
	    n.sendMsg("/poem",  "the eyes’ color");
	    9.75.wait;
        n.sendMsg("/poem", "reflect that");
	    9.75.wait;
        n.sendMsg("/poem", "of the land.");
	    9.75.wait;

        n.sendMsg("/poem", "If there is"); //没有边界 没有信仰 是否得以成全 38
		7.6.wait;
	    n.sendMsg("/poem",  "no border,");
	    7.6.wait;
        n.sendMsg("/poem", "no belief,");
	    7.6.wait;
        n.sendMsg("/poem", "can it");
	    7.6.wait;
        n.sendMsg("/poem", "be fulfilled?");
		7.6.wait;

	    n.sendMsg("/poem", "If there is"); //没有颜色 没有光彩 是否就没有黑与白 40
		7.5.wait;
	    n.sendMsg("/poem", "no light,");
	    7.5.wait;
        n.sendMsg("/poem", "no color,");
	    7.5.wait;
        n.sendMsg("/poem", "is there");
	    7.5.wait;
        n.sendMsg("/poem", "no black?");
		7.5.wait;
	    n.sendMsg("/poem", "and white?");  //+5
		7.5.wait;


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
        n.sendMsg("/poem", "If there is"); //没有得到 没有失去 是否还有感知 33
		10.wait;
	    n.sendMsg("/poem",  "no gain,");
	    10.wait;
        n.sendMsg("/poem", "no loss,");
	    10.wait;
        n.sendMsg("/poem", "can it");
	    10.wait;
        n.sendMsg("/poem", "be felt?");
		10.wait;

	    n.sendMsg("/poem", "If there is"); //没有黑夜 没有光明 是否还能感知生命 42
		10.wait;
	    n.sendMsg("/poem",  "no darkness,");
	    10.wait;
        n.sendMsg("/poem", "no light, ");
	    10.wait;
        n.sendMsg("/poem", "can it ");
	    10.wait;
        n.sendMsg("/poem", "be alive?");
		10.wait;
	}});
)
