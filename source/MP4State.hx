package;

import flixel.FlxState;
#if (hxCodec >= "3.0.0") import hxcodec.flixel.FlxVideo as VideoHandler;
#elseif (hxCodec >= "2.6.1") import hxcodec.VideoHandler as VideoHandler;
#elseif (hxCodec == "2.6.0") import VideoHandler;
#else import vlc.MP4Handler as VideoHandler; #end

/**
 * Legit Just Plays An MP4 In A State
 */
class MP4State extends FlxState {
    var videoName:String;
    var canSkip:Bool = false;
    var onComplete:Dynamic;

    override public function new(videoName:String, canSkip:Bool = false, ?onComplete:Dynamic) {
        super();
        this.videoName = videoName;
        this.canSkip = canSkip;
        this.onComplete = onComplete;
    }

    override public function create() {
        super.create();

        var video:VideoHandler = new VideoHandler();
        #if (hxCodec >= "2.5.1")
        video.canSkip = canSkip;
        video.finishCallback = onComplete;
        video.playVideo(Paths.video(videoName));
        #elseif (hxCodec >= "3.0.0")
        video.onEndReached.add(onComplete);
        video.play(Paths.video(videoName));
        #end
    }

    override public function update(elapsed) {
        super.update(elapsed);
    }
}