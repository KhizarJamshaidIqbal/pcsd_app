// ignore_for_file: camel_case_types, unused_element, file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, non_constant_identifier_names, avoid_print, depend_on_referenced_packages, unused_field, prefer_final_fields, prefer_typing_uninitialized_variables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/user/features/Dashboard/UV_Light_Preview.dart';
import '../../../model/static_PNI.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PNI_details extends StatefulWidget {
  PNI_details(
      {super.key,
      required this.imgeUrl,
      required this.Title,
      required this.initialIndex});
  String imgeUrl;
  String Title;
  final int initialIndex;
  dynamic list = Pakistan_Note_api.PNI_data;
  @override
  State<PNI_details> createState() => _PNI_detailsState();
}

class _PNI_detailsState extends State<PNI_details> {
  final controller = TransformationController();
  bool onbuttonclick = false;
  late int currentIndex;
  bool isZoomed = false;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  void goToPreviousItem() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  void goToNextItem() {
    if (currentIndex < widget.list.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  bool get showNextButton => currentIndex < widget.list.length - 1;
  bool get showPreviousButton => currentIndex > 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: globalColors.SecondaryColor,
        appBar: _appbar,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(gradient: globalColors.primaryGradient),
            child: Stack(
              children: [
                Column(
                  children: [
                    InteractiveViewer(
                      boundaryMargin: EdgeInsets.all(2),
                      minScale: .5,
                      maxScale: 9,
                      transformationController: controller,
                      onInteractionStart: (_) => setState(() {
                        isZoomed = false;
                      }),
                      onInteractionEnd: (details) {
                        setState(() {
                          isZoomed = controller.value.getMaxScaleOnAxis() > 1;
                        });
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height: 700,
                        child: Image(
                            image: AssetImage(
                                widget.list[currentIndex]["PNI_Images"]),
                            fit: BoxFit.fill),
                      ),
                    ),
                    if (currentIndex < 1)
                      Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * .9999,
                            child: ElevatedButton(
                              onPressed: () => goToNextItem(),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff1C6758),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.zero))),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.nextNote,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                        color: globalColors.WhiteColor),
                                  ), // <-- Text
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.arrow_forward_ios_outlined,
                                      color: globalColors.WhiteColor),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (currentIndex > 0 &&
                        currentIndex < widget.list.length - 1)
                      Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * .5,
                            child: ElevatedButton.icon(
                              onPressed: () => goToPreviousItem(),
                              icon: Icon(Icons.arrow_back_ios_new_outlined,
                                  color: globalColors.WhiteColor),
                              label: Text(
                                AppLocalizations.of(context)!.backNote,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                    color: globalColors.WhiteColor),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff3AD087),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.zero))),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * .5,
                            child: ElevatedButton(
                              onPressed: () => goToNextItem(),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff1C6758),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.zero))),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.nextNote,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                        color: globalColors.WhiteColor),
                                  ), // <-- Text
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.arrow_forward_ios_outlined,
                                      color: globalColors.WhiteColor),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (currentIndex == 7)
                      Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * .9999,
                            child: ElevatedButton.icon(
                              onPressed: () => goToPreviousItem(),
                              icon: Icon(Icons.arrow_back_ios_new_outlined,
                                  color: globalColors.WhiteColor),
                              label: Text(
                                AppLocalizations.of(context)!.backNote,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                    color: globalColors.WhiteColor),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff3AD087),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.zero))),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                Visibility(
                  visible: isZoomed,
                  child: Positioned(
                    top: 570,
                    left: 280,
                    child: FloatingActionButton(
                      child: Icon(Icons.restore),
                      tooltip: "Restore Now",
                      backgroundColor: Color(0xff1C6758),
                      onPressed: () => reset(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar get _appbar => AppBar(
        centerTitle: true,
        title: Text(
          widget.list[currentIndex]["RS"] +
              ' ' +
              AppLocalizations.of(context)!.rupee,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: "Inter",
              color: globalColors.WhiteColor),
        ),
        backgroundColor: globalColors.primaryColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 20),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_new_rounded,
                  color: globalColors.WhiteColor)),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border:
                        Border.all(color: globalColors.WhiteColor, width: 2)),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UVLightPreview(
                          uvImageUrl: widget.list[currentIndex]["UV_Light"][0]
                              ["UV"],
                        ),
                      ),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.uvLook,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: globalColors.WhiteColor,
                    ),
                  ),
                ),
              ))
        ],
      );

  void reset() {
    setState(() {
      controller.value = Matrix4.identity();
    });
  }
}
