package;

class CharSongList
{
	public static var data:Map<String, Array<String>> = [
		"finale" => ["final-escape"],
		"majin" => ["endless", "endless-og"],
		"lord x" => ["cycles"],
		"tails doll" => ["sunshine", "soulless"],
		"fleetway" => ["chaos"],
		"fatalerror" => ["fatality"],
		"chaotix" => ["my-horizon", "our-horizon"],
		"curse" => ["malediction"],
		"starved" => ["prey", "fight-or-flight"],
		"xterion" => ["substantial", "digitalized"],
		"needlemouse" => ["round-a-bout"],
		"hog" => ["manual-blast"],
		"sunky" => ["milk"],
		"sanic" => ["too-fest"],
		"coldsteel" => ["personel"],
    "mrsys" => ["unbeatable"]
	];

	public static var characters:Array<String> = [
		// just for ordering
		"finale",
		"majin",
		"lord x",
		"tails doll",
		"fleetway",
		"fatalerror",
		"chaotix",
		"curse",
		"starved",
		"xterion",
		"needlemouse",
		"hog",
		"sunky",
		"sanic",
		"coldsteel",
    "mrsys"
	];

	public static var charactersUnlocked:Array<String> = [
		// just for ordering
		"majin",
		"lord x",
		"tails doll",
		"fleetway",
		"fatalerror",
		"chaotix",
		"curse",
		"starved",
		"xterion",
		"needlemouse",
		"hog",
		"sunky",
		"sanic",
		"coldsteel",
    "mrsys"
	];

	public static function init()
	{
		var unlockedShit:Array<String> = flixel.FlxG.save.data.charactersUnlocked;

    trace(unlockedShit);

		for (str in unlockedShit)
		{
				charactersUnlocked.push(str);
		}
	}

	public static function getSongsByChar(char:String)
	{
		if (data.exists(char))
			return data.get(char);
		return [];
	}
}