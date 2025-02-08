package;

class CharSongList
{
	static var loaded:Bool = false;

	public static var data:Map<String, Array<String>> = [
		"majin" => ["endless", "endless-og"],
		"lord x" => ["cycles"],
		"tails doll" => ["sunshine", "soulless"],
		"requital" => ["forestall-desire", "deception"],
		"fleetway" => ["chaos"],
		"fatalerror" => ["fatality"],
		"chaotix" => ["my-horizon", "our-horizon"],
		"yourself..." => ["yourself"],
		"curse" => ["malediction"],
		"satanos" => ["perdition"],
		"starved" => ["prey", "fight-or-flight"],
		"xterion" => ["substantial", "digitalized"],
		"sl4sh" => ["b4cksl4sh"],
		"needlemouse" => ["round-a-bout"],
		"hog" => ["manual-blast"],
		"sunky" => ["milk"],
		"sanic" => ["too-fest"],
		"coldsteel" => ["personel"],
	];

	public static var characters:Array<String> = [
		"majin",
		"lord x",
		"tails doll",
		"requital",
		"fleetway",
		"fatalerror",
		"yourself...",
		"chaotix",
		"curse",
		"sl4sh",
		"satanos",
		"starved",
		"xterion",
		"sl4sh",
		"needlemouse",
		"hog",
		"sunky",
		"sanic",
		"coldsteel",
	];

	public static var charactersUnlocked:Array<String> = [];

	public static function init()
	{
		if (!loaded)
		{
			loaded = true;
			
			if (flixel.FlxG.save.data.charactersUnlocked != null) {
				var unlockedShit:Array<String> = flixel.FlxG.save.data.charactersUnlocked;

				for (str in unlockedShit)
				{
					charactersUnlocked.push(str);
				}
			} else {
				flixel.FlxG.save.data.charactersUnlocked = [];
			}
		}
	}

	public static function save()
		for (str in charactersUnlocked)
			if (!flixel.FlxG.save.data.charactersUnlocked.contains(str))
				flixel.FlxG.save.data.charactersUnlocked.push(str);

	public static function getSongsByChar(char:String)
	{
		if (data.exists(char))
			return data.get(char);
		return [];
	}
}
