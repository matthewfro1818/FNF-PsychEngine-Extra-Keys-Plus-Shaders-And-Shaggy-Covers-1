package states.stages;

import states.stages.objects.*;
import backend.StageData;

class DaveHouse extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	override function create(bgName:String, revertedBG:Bool)
	{
		botplayTxt = new FlxText(healthBarBG.x + healthBarBG.width / 2 - 75, healthBarBG.y + (FlxG.save.data.downscroll ? 100 : -100), 0,
		"BOTPLAY", 20);
		botplayTxt.setFormat((SONG.song.toLowerCase() == "overdrive") ? Paths.font("ariblk.ttf") : font, 42, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		botplayTxt.scrollFactor.set();
		botplayTxt.borderSize = 3;
		botplayTxt.visible = botPlay;
		add(botplayTxt);

		case 'house' | 'house-night' | 'house-sunset':
				
        	var skyType:String = '';
		var assetType:String = '';
		switch (bgName)
		{
			case 'house':
				stageName = 'daveHouse';
				skyType = 'sky';
			case 'house-night':
				stageName = 'daveHouse_night';
				skyType = 'sky_night';
				assetType = 'night/';
			case 'house-sunset':
				stageName = 'daveHouse_sunset';
				skyType = 'sky_sunset';
		}
		var bg:BGSprite = new BGSprite('bg', -600, -300, Paths.image('backgrounds/shared/${skyType}'), null, 0.6, 0.6);
		add(bg);

		var stageHills:BGSprite = new BGSprite('stageHills', -834, -159, Paths.image('backgrounds/dave-house/${assetType}hills'), null, 0.7, 0.7);
		add(stageHills);

		var grassbg:BGSprite = new BGSprite('grassbg', -1205, 580, Paths.image('backgrounds/dave-house/${assetType}grass bg'), null);
		sprites.add(grassbg);
		add(grassbg);

		var gate:BGSprite = new BGSprite('gate', -755, 250, Paths.image('backgrounds/dave-house/${assetType}gate'), null);
		sprites.add(gate);
		add(gate);

		var stageFront:BGSprite = new BGSprite('stageFront', -832, 505, Paths.image('backgrounds/dave-house/${assetType}grass'), null);
		sprites.add(stageFront);
		add(stageFront);

		if (SONG.song.toLowerCase() == 'insanity' || states.PlayState.localFunny == CharacterFunnyEffect.Recurser)
		{
			var bg:BGSprite = new BGSprite('bg', -600, -200, Paths.image('backgrounds/void/redsky_insanity'), null, 1, 1, true, true);
			bg.alpha = 0.75;
			bg.visible = false;
			add(bg);
			// below code assumes shaders are always enabled which is bad
			voidShader(bg);
		}

			
		var variantColor = getBackgroundColor(stageName);
		if (stageName != 'daveHouse_night')
		{
			stageHills.color = variantColor;
			grassbg.color = variantColor;
			gate.color = variantColor;
			stageFront.color = variantColor;
		}
		
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
		// Code here
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
