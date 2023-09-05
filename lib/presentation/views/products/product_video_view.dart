
import 'package:flutter/material.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ProductVideoView extends StatefulWidget {

  String url,title;


  ProductVideoView({required this.url,required this.title});


  @override
  State<ProductVideoView> createState() => _VideoDetailsState();
}
class _VideoDetailsState extends State<ProductVideoView> {



  late String url;
  late YoutubePlayerController controller;

  @override
  void initState() {

    super.initState();
    url=widget.url;
    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

  }

  @override
  void deactivate() {
    super.deactivate();
    controller.pause();
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      builder: (context,player)=>

          Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor:ColorsManager.primary,
              toolbarHeight: 1,
            ),
            body:


            Column(
              children: [

                SizedBox(
                    height:380,
                    child: player),

              ],
            ),
          ),
      player:
      YoutubePlayer(

        controller: controller,

        showVideoProgressIndicator: true,

        liveUIColor: Colors.amber,
        // bottomActions: [
        //   CurrentPosition(),
        //   ProgressBar(isExpanded: true),
        //   //     TotalDuration(),
        // ],

      ),

    );
  }
}
