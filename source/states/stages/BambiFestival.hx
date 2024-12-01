package states.stages;

import states.stages.objects.*;
import backend.StageData;

class BambiFestival extends BaseStage
{
	var defaultCamZoom:Float = 1.05;

	override function create(bgName:String, revertedBG:Bool)
	{
		botplayTxt = new FlxText(healthBarBG.x + healthBarBG.width / 2 - 75, healthBarBG.y + (FlxG.save.data.downscroll ? 100 : -100), 0,
		"BOTPLAY", 20);
		botplayTxt.setFormat((SONG.song.toLowerCase() == "overdrive") ? Paths.font("ariblk.ttf") : font, 42, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		botplayTxt.scrollFactor.set();
		botplayTxt.borderSize = 3;
		botplayTxt.visible = botPlay;
		add(botplayTxt);
			case 'festival':
				bgZoom = 0.7;
				stageName = 'festival';
				
				var mainChars:Array<Dynamic> = null;
				switch (SONG.song.toLowerCase())
				{
					case 'shredder':
						mainChars = [
							//char name, prefix, size, x, y, flip x
							['dave', 'idle', 0.8, 175, 100],
							['tristan', 'bop', 0.4, 800, 325]
						];
					case 'greetings':
						if (isGreetingsCutscene)
						{
							mainChars = [
								['bambi', 'bambi idle', 0.9, 400, 350],
								['tristan', 'bop', 0.4, 800, 325]
							];
						}
						else
						{
							mainChars = [
								['dave', 'idle', 0.8, 175, 100],
								['bambi', 'bambi idle', 0.9, 700, 350],
							];
						}
					case 'interdimensional':
						mainChars = [
							['bambi', 'bambi idle', 0.9, 400, 350],
							['tristan', 'bop', 0.4, 800, 325]
						];
				}
				var bg:BGSprite = new BGSprite('bg', -400, -230, Paths.image('backgrounds/shared/sky_festival'), null, 0.6, 0.6);
				sprites.add(bg);
				add(bg);

				var flatGrass:BGSprite = new BGSprite('flatGrass', 800, -100, Paths.image('backgrounds/festival/gm_flatgrass'), null, 0.7, 0.7);
				sprites.add(flatGrass);
				add(flatGrass);

				var farmHouse:BGSprite = new BGSprite('farmHouse', -300, -150, Paths.image('backgrounds/festival/farmHouse'), null, 0.7, 0.7);
				sprites.add(farmHouse);
				add(farmHouse);
				
				var hills:BGSprite = new BGSprite('hills', -1000, -100, Paths.image('backgrounds/festival/hills'), null, 0.7, 0.7);
				sprites.add(hills);
				add(hills);

				var corn:BGSprite = new BGSprite('corn', -1000, 120, 'backgrounds/festival/corn', [
					new Animation('corn', 'idle', 5, true, [false, false])
				], 0.85, 0.85, true, true);
				corn.animation.play('corn');
				sprites.add(corn);
				add(corn);

				var cornGlow:BGSprite = new BGSprite('cornGlow', -1000, 120, 'backgrounds/festival/cornGlow', [
					new Animation('cornGlow', 'idle', 5, true, [false, false])
				], 0.85, 0.85, true, true);
				cornGlow.blend = BlendMode.ADD;
				cornGlow.animation.play('cornGlow');
				sprites.add(cornGlow);
				add(cornGlow);
				
				var backGrass:BGSprite = new BGSprite('backGrass', -1000, 475, Paths.image('backgrounds/festival/backGrass'), null, 0.85, 0.85);
				sprites.add(backGrass);
				add(backGrass);
				
				var crowd = new BGSprite('crowd', -500, -150, 'backgrounds/festival/crowd', [
					new Animation('idle', 'crowdDance', 24, true, [false, false])
				], 0.85, 0.85, true, true);
				crowd.animation.play('idle');
				sprites.add(crowd);
				crowdPeople.add(crowd);
				add(crowd);
				
				for (i in 0...mainChars.length)
				{					
					var crowdChar = new BGSprite(mainChars[i][0], mainChars[i][3], mainChars[i][4], 'backgrounds/festival/mainCrowd/${mainChars[i][0]}', [
						new Animation('idle', mainChars[i][1], 24, false, [false, false], null)
					], 0.85, 0.85, true, true);
					crowdChar.setGraphicSize(Std.int(crowdChar.width * mainChars[i][2]));
					crowdChar.updateHitbox();
					sprites.add(crowdChar);
					crowdPeople.add(crowdChar);
					add(crowdChar);
				}
				
				var frontGrass:BGSprite = new BGSprite('frontGrass', -1300, 600, Paths.image('backgrounds/festival/frontGrass'), null, 1, 1);
				sprites.add(frontGrass);
				add(frontGrass);

				var stageGlow:BGSprite = new BGSprite('stageGlow', -450, 300, 'backgrounds/festival/generalGlow', [
					new Animation('glow', 'idle', 5, true, [false, false])
				], 0, 0, true, true);
				stageGlow.blend = BlendMode.ADD;
				stageGlow.animation.play('glow');
				sprites.add(stageGlow);
				add(stageGlow);
		
		backgroundSprites = createBackgroundSprites(StageData.stage, false);
		switch (SONG.song.toLowerCase())
		{
			case 'secret':
				UsingNewCam = true;
		}
		switch (SONG.song.toLowerCase())
		{
			case 'polygonized' | 'interdimensional':
			var stage = SONG.song.toLowerCase() != 'interdimensional' ? 'house-night' : 'festival';
			revertedBG = createBackgroundSprites(stage, true);
			for (bgSprite in revertedBG)
			{
				bgSprite.color = getBackgroundColor(SONG.song.toLowerCase() != 'interdimensional' ? 'daveHouse_night' : 'festival');
				bgSprite.alpha = 0;
			}
		}
		switch (curSong.toLowerCase())
		{
			case 'insanity':
				preload('backgrounds/void/redsky');
				preload('backgrounds/void/redsky_insanity');
		}
	}
	override function createPost()
	{
		// Use this function to layer things above characters!
	}

	override function update(elapsed:Float)
	{
		// Code here
	}

	override function destroy()
	{
		// Code here
	}

	
	override function countdownTick(count:Countdown, num:Int)
	{
		switch(count)
		{
			case THREE: //num 0
			case TWO: //num 1
			case ONE: //num 2
			case GO: //num 3
			case START: //num 4
		}
	}

	override function startSong()
	{
		// Code here
	}

	// Steps, Beats and Sections:
	//    curStep, curDecStep
	//    curBeat, curDecBeat
	//    curSection
	override function stepHit()
	{
		switch (SONG.song.toLowerCase())
		{
			case 'blocked':
				switch (curStep)
				{
					case 128:
						defaultCamZoom += 0.1;
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						black = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
						black.screenCenter();
						black.alpha = 0;
						add(black);
						FlxTween.tween(black, {alpha: 0.6}, 1);
						makeInvisibleNotes(true);
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub1'), 0.02, 1);
					case 165:
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub2'), 0.02, 1);
					case 188:
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub3'), 0.02, 1);
					case 224:
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub4'), 0.02, 1);
					case 248:
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub5'), 0.02, 0.5, {subtitleSize: 60});
					case 256:
						defaultCamZoom -= 0.1;
						FlxG.camera.flash();
						FlxTween.tween(black, {alpha: 0}, 1);
						makeInvisibleNotes(false);
					case 640:
						FlxG.camera.flash();
						black.alpha = 0.6;
						defaultCamZoom += 0.1;
					case 768:
						FlxG.camera.flash();
						defaultCamZoom -= 0.1;
						black.alpha = 0;
					case 1028:
						makeInvisibleNotes(true);
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub6'), 0.02, 1.5);
					case 1056:
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub7'), 0.02, 1);
					case 1084:
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub8'), 0.02, 1);
					case 1104:
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub9'), 0.02, 1);
					case 1118:
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub10'), 0.02, 1);
					case 1143:
						subtitleManager.addSubtitle(LanguageManager.getTextString('blocked_sub11'), 0.02, 1, {subtitleSize: 45});
						makeInvisibleNotes(false);
					case 1152:
						FlxTween.tween(black, {alpha: 0.4}, 1);
						defaultCamZoom += 0.3;
					case 1200:
						#if SHADERS_ENABLED
						if(CompatTool.save.data.compatMode != null && CompatTool.save.data.compatMode == false)
							{
								camHUD.setFilters([new ShaderFilter(blockedShader.shader)]);
							}
						#end
						FlxTween.tween(black, {alpha: 0.7}, (Conductor.stepCrochet / 1000) * 8);
					case 1216:
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						camHUD.setFilters([]);
						remove(black);
						defaultCamZoom -= 0.3;
				}
			case 'corn-theft':
				switch (curStep)
				{
					case 668:
						defaultCamZoom += 0.1;
					case 784:
						defaultCamZoom += 0.1;
					case 848:
						defaultCamZoom -= 0.2;
					case 916:
						FlxG.camera.flash();
					case 935:
						defaultCamZoom += 0.2;
						black = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
						black.screenCenter();
						black.alpha = 0;
						add(black);
						FlxTween.tween(black, {alpha: 0.6}, 1);
						makeInvisibleNotes(true);
						subtitleManager.addSubtitle(LanguageManager.getTextString('ctheft_sub1'), 0.02, 1);
					case 945:
						subtitleManager.addSubtitle(LanguageManager.getTextString('ctheft_sub2'), 0.02, 1);
					case 976:
						subtitleManager.addSubtitle(LanguageManager.getTextString('ctheft_sub3'), 0.02, 0.5);
					case 982:
						subtitleManager.addSubtitle(LanguageManager.getTextString('ctheft_sub4'), 0.02, 1);
					case 992:
						subtitleManager.addSubtitle(LanguageManager.getTextString('ctheft_sub5'), 0.02, 1);
					case 1002:
						subtitleManager.addSubtitle(LanguageManager.getTextString('ctheft_sub6'), 0.02, 0.3);
					case 1007:
						subtitleManager.addSubtitle(LanguageManager.getTextString('ctheft_sub7'), 0.02, 0.3);
					case 1033:
						subtitleManager.addSubtitle("Bye Baa!", 0.02, 0.3, {subtitleSize: 45});
						FlxTween.tween(dad, {alpha: 0}, (Conductor.stepCrochet / 1000) * 6);
						FlxTween.tween(black, {alpha: 0}, (Conductor.stepCrochet / 1000) * 6);
						FlxTween.num(defaultCamZoom, defaultCamZoom + 0.2, (Conductor.stepCrochet / 1000) * 6, {}, function(newValue:Float)
						{
							defaultCamZoom = newValue;
						});
						makeInvisibleNotes(false);
					case 1040:
						defaultCamZoom = 0.8; 
						dad.alpha = 1;
						remove(black);
						FlxG.camera.flash();
				}
			case 'maze':
				switch (curStep)
				{
					case 466:
						defaultCamZoom += 0.2;
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						black = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
						black.screenCenter();
						black.alpha = 0;
						add(black);
						FlxTween.tween(black, {alpha: 0.6}, 1);
						makeInvisibleNotes(true);
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub1'), 0.02, 1);
					case 476:
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub2'), 0.02, 0.7);
					case 484:
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub3'), 0.02, 1);
					case 498:
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub4'), 0.02, 1);
					case 510:
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub5'), 0.02, 1, {subtitleSize: 60});
						makeInvisibleNotes(false);
					case 528:
						 defaultCamZoom = 0.8;
						black.alpha = 0;
						FlxG.camera.flash();
					case 832:
						defaultCamZoom += 0.2;
						FlxTween.tween(black, {alpha: 0.4}, 1);
					case 838:
						makeInvisibleNotes(true);
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub6'), 0.02, 1);
					case 847:
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub7'), 0.02, 0.5);
					case 856:
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub8'), 0.02, 1);
					case 867:
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub9'), 0.02, 1, {subtitleSize: 40});
					case 879:
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub10'), 0.02, 1);
					case 890:
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub11'), 0.02, 1);
					case 902:
						subtitleManager.addSubtitle(LanguageManager.getTextString('maze_sub12'), 0.02, 1, {subtitleSize: 60});
						makeInvisibleNotes(false);
					case 908:
						FlxTween.tween(black, {alpha: 1}, (Conductor.stepCrochet / 1000) * 4);
					case 912:
						if (!spotLightPart)
						{
							spotLightPart = true;
							defaultCamZoom -= 0.1;
							FlxG.camera.flash(FlxColor.WHITE, 0.5);
	
							spotLight = new FlxSprite().loadGraphic(Paths.image('spotLight'));
							spotLight.blend = BlendMode.ADD;
							spotLight.setGraphicSize(Std.int(spotLight.width * (dad.frameWidth / spotLight.width) * spotLightScaler));
							spotLight.updateHitbox();
							spotLight.alpha = 0;
							spotLight.origin.set(spotLight.origin.x,spotLight.origin.y - (spotLight.frameHeight / 2));
							add(spotLight);
	
							spotLight.setPosition(dad.getGraphicMidpoint().x - spotLight.width / 2, dad.getGraphicMidpoint().y + dad.frameHeight / 2 - (spotLight.height));	
							updateSpotlight(false);
							
							FlxTween.tween(black, {alpha: 0.6}, 1);
							FlxTween.tween(spotLight, {alpha: 0.7}, 1);
						}
					case 1168:
						spotLightPart = false;
						FlxTween.tween(spotLight, {alpha: 0}, 1, {onComplete: function(tween:FlxTween)
						{
							remove(spotLight);
						}});
						FlxTween.tween(black, {alpha: 0}, 1);
					case 1232:
						FlxG.camera.flash();
				}
		}
	}
	override function beatHit()
	{
		// Code here
	}
	override function sectionHit()
	{
		// Code here
	}

	// Substates for pausing/resuming tweens and timers
	override function closeSubState()
	{
		if(paused)
		{
			//timer.active = true;
			//tween.active = true;
		}
	}

	override function openSubState(SubState:flixel.FlxSubState)
	{
		if(paused)
		{
			//timer.active = false;
			//tween.active = false;
		}
	}

	// For events
	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		switch(eventName)
		{
			case "My Event":
		}
	}
	override function eventPushed(event:objects.Note.EventNote)
	{
		// used for preloading assets used on events that doesn't need different assets based on its values
		switch(event.event)
		{
			case "My Event":
				//precacheImage('myImage') //preloads images/myImage.png
				//precacheSound('mySound') //preloads sounds/mySound.ogg
				//precacheMusic('myMusic') //preloads music/myMusic.ogg
		}
	}
	override function eventPushedUnique(event:objects.Note.EventNote)
	{
		// used for preloading assets used on events where its values affect what assets should be preloaded
		switch(event.event)
		{
			case "My Event":
				switch(event.value1)
				{
					// If value 1 is "blah blah", it will preload these assets:
					case 'blah blah':
						//precacheImage('myImageOne') //preloads images/myImageOne.png
						//precacheSound('mySoundOne') //preloads sounds/mySoundOne.ogg
						//precacheMusic('myMusicOne') //preloads music/myMusicOne.ogg

					// If value 1 is "coolswag", it will preload these assets:
					case 'coolswag':
						//precacheImage('myImageTwo') //preloads images/myImageTwo.png
						//precacheSound('mySoundTwo') //preloads sounds/mySoundTwo.ogg
						//precacheMusic('myMusicTwo') //preloads music/myMusicTwo.ogg
					
					// If value 1 is not "blah blah" or "coolswag", it will preload these assets:
					default:
						//precacheImage('myImageThree') //preloads images/myImageThree.png
						//precacheSound('mySoundThree') //preloads sounds/mySoundThree.ogg
						//precacheMusic('myMusicThree') //preloads music/myMusicThree.ogg
				}
		}
	}

	// Note Hit/Miss
	override function goodNoteHit(note:Note)
	{
		// Code here
	}

	override function opponentNoteHit(note:Note)
	{
		// Code here
	}

	override function noteMiss(note:Note)
	{
		// Code here
	}

	override function noteMissPress(direction:Int)
	{
		// Code here
	}
}
