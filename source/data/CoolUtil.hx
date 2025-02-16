package data;

import flixel.FlxG;
import openfl.utils.Assets;
import lime.utils.Assets as LimeAssets;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
#if sys
import sys.io.File;
import sys.FileSystem;
#else
import openfl.utils.Assets;
#end
import flixel.math.FlxPoint;

using StringTools;

class CoolUtil
{
	// [Difficulty name, Chart file suffix]
	public static var difficultyStuff:Array<Dynamic> = [
		['Easy', '-easy'],
		['Normal', ''],
		['Hard', '-hard'],
		["Encore", "-encore"]
	];
	public static inline function GetPlayer(note:Note) // schmovin
	{
		return note.mustPress ? 1 : 0;
	}

	public static inline function GetTotalColumn(note:Note)
	{
		return note.noteData + GetPlayer(note) * 4;
	}

	public static function difficultyString():String
	{
		return difficultyStuff[PlayState.storyDifficulty][0].toUpperCase();
	}

	public static function rotate(x:Float, y:Float, angle:Float, ?point:FlxPoint):FlxPoint{
		var p = point==null?FlxPoint.get():point;
		p.set(
			(x*Math.cos(angle))-(y*Math.sin(angle)),
			(x*Math.sin(angle))+(y*Math.cos(angle))
		);
		return p;
	}

	inline public static function scale(x:Float,l1:Float,h1:Float,l2:Float,h2:Float):Float
		return ((x - l1) * (h2 - l2) / (h1 - l1) + l2);

	public static function boundTo(value:Float, min:Float, max:Float):Float {
		var newValue:Float = value;
		if(newValue < min) newValue = min;
		else if(newValue > max) newValue = max;
		return newValue;
	}

	inline public static function quantize(f:Float, interval:Float){
		return Std.int((f+interval/2)/interval)*interval;
	}

	public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = [];
		#if sys
		if(FileSystem.exists(path)) daList = File.getContent(path).trim().split('\n');
		#else
		if(Assets.exists(path)) daList = Assets.getText(path).trim().split('\n');
		#end

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	public static function dominantColor(sprite:flixel.FlxSprite):Int{
		var countByColor:Map<Int, Int> = [];
		for(col in 0...sprite.frameWidth){
			for(row in 0...sprite.frameHeight){
			  var colorOfThisPixel:Int = sprite.pixels.getPixel32(col, row);
			  if(colorOfThisPixel != 0){
				  if(countByColor.exists(colorOfThisPixel)){
				    countByColor[colorOfThisPixel] =  countByColor[colorOfThisPixel] + 1;
				  }else if(countByColor[colorOfThisPixel] != 13520687 - (2*13520687)){
					 countByColor[colorOfThisPixel] = 1;
				  }
			  }
			}
		 }
		var maxCount = 0;
		var maxKey:Int = 0;//after the loop this will store the max color
		countByColor[flixel.util.FlxColor.BLACK] = 0;
			for(key in countByColor.keys()){
			if(countByColor[key] >= maxCount){
				maxCount = countByColor[key];
				maxKey = key;
			}
		}
		return maxKey;
	}

	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}

	//uhhhh does this even work at all? i'm starting to doubt
	public static function precacheSound(sound:String, ?library:String = null):Void {
		if(!Assets.cache.hasSound(Paths.sound(sound, library))) {
			FlxG.sound.cache(Paths.sound(sound, library));
		}
	}

	public static function browserLoad(site:String) {
		#if linux
		Sys.command('/usr/bin/xdg-open', [site]);
		#else
		FlxG.openURL(site);
		#end
	}

	public static function unzipFile(srcZip:String, dstDir:String, ignoreRootFolder:Bool = false) {
        trace("Unzipping archive");
		
        FileSystem.createDirectory(dstDir);
        
        var inFile = sys.io.File.read(srcZip);
        var entries = haxe.zip.Reader.readZip(inFile);
        inFile.close();

        for(entry in entries) {
            var fileName = entry.fileName;
            if (fileName.charAt(0) != "/" && fileName.charAt(0) != "\\" && fileName.split("..").length <= 1) {
                var dirs = ~/[\/\\]/g.split(fileName);
                if ((ignoreRootFolder != false && dirs.length > 1) || ignoreRootFolder == false) {
                    if (ignoreRootFolder != false) {
                        dirs.shift();
                    }
                
                    var path = "";
                    var file = dirs.pop();
                    for (d in dirs) {
                        path += d;
                        sys.FileSystem.createDirectory(dstDir + "/" + path);
                        path += "/";
                    }
                
                    if (file == "") {
                        continue;
                    }

                    path += file;
                
                    var data = haxe.zip.Reader.unzip(entry);
                    var f = File.write(dstDir + "/" + path, true);
                    f.write(data);
                    f.close();
                }
            }
        } //_entry

        var contents = sys.FileSystem.readDirectory(dstDir);
        if (contents.length > 0) {
            trace('Unzipped successfully to ${dstDir}: (${contents.length} top level items found)');
        } else {
            throw 'No contents found in "${dstDir}"';
        }
    }
}