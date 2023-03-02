import 'package:flutter/material.dart';
import 'package:overlay_proj2/widgets/custom_overlay_design.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isShown=false;
  final GlobalKey _gereenFABKey=GlobalKey();
  final GlobalKey _redFABKey=GlobalKey();
  OverlayEntry? overlayEntry;
  late Color _selectedColor; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("Overlay example 2"),centerTitle: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                key: _gereenFABKey,
                backgroundColor: Colors.green,
                child:const Icon(Icons.add),
                onPressed: (){
                  _selectedColor=Colors.green;
                  removeOverlay();
                  showOverlay(context, _gereenFABKey);
                },
                ),
              FloatingActionButton(
                key: _redFABKey,
                backgroundColor: Colors.red,
                child: const Icon(Icons.add),
                onPressed: (){
                  _selectedColor=Colors.red;
                  removeOverlay();
                  showOverlay(context, _redFABKey);
                },
                ),
            ],
          ),
          const SizedBox(height: 150,),
          ElevatedButton(onPressed: ()=>removeOverlay(), child:const Text("Remove Overlay")),
        ],
      ),
    );
  }

  void showOverlay(BuildContext context,GlobalKey keyOfWidget){

    OverlayState overlayState =Overlay.of(context);

    /*This render box will be used to access location and offset of **target widget**
      1-Offset: Contain the distance from top and left for **target widget**
      2-Size: contain the width and height of the **target widget**. 
    */
    RenderBox renderBox=keyOfWidget.currentContext!.findRenderObject() as RenderBox;
    Offset offsetOfFAB=renderBox.localToGlobal(Offset.zero);
    Size size=renderBox.size;

    overlayEntry=OverlayEntry(
      builder: (_){
        return Positioned(//postion the **Customized widget** based on **target widget** postion info
          left: offsetOfFAB.dx-(100-size.height)/2,
          bottom:MediaQuery.of(context).size.height-offsetOfFAB.dy-size.height-(100-size.height)/2,
          child: BuildYourCustomizedWidget(color: _selectedColor,),
        );
      },
    );

    overlayState.insert(overlayEntry!);
  }

  void removeOverlay(){
    if(overlayEntry!=null){
      overlayEntry!.remove();
      overlayEntry=null;
    }
  }

}