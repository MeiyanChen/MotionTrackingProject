//load the audio file

(
~material1 = Array.new;
~folder1 = PathName.new("/Volumes/Samsung_T5/HFM Karlsruhe/Projects/Motion tracking project/Material1Ochestra/Bounces/");


~folder1.entries.do({
	arg path;
	~material1 = ~material1.add(Buffer.read(s, path.fullPath));
});




~material2 = Array.new;
~folder2 = PathName.new("/Volumes/Samsung_T5/HFM Karlsruhe/Projects/Motion tracking project/PencilSound/");


~folder2.entries.do({
	arg path;
	~material2 = ~material2.add(Buffer.read(s, path.fullPath));
});
)

/*
play it raw
~material1[0].play;
~material1[1].play;
~material1[2].play;
~material1[3].play;
~material1[4].play;
~material1[5].play;
~material1[6].play;
~material1[7].play;

~material2[0].play;
~material2[1].play;
