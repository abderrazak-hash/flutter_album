library flutter_album;

import 'package:flutter/material.dart';

class FlutterAlbum extends StatefulWidget {
  List<String> items;
  final double albumWidth;
  final double space, size;
  final AlbumShape shape;
  final double borderWidth;
  final Color borderColor;
  FlutterAlbum({
    Key? key,
    required this.items,
    this.space = 0.0,
    this.albumWidth = 300.0,
    this.size = 60.0,
    this.borderWidth = 2.0,
    this.borderColor = Colors.grey,
    this.shape = AlbumShape.circle,
  }) : super(key: key);

  @override
  State<FlutterAlbum> createState() => _FlutterAlbumState();
}

class _FlutterAlbumState extends State<FlutterAlbum> {
  double edge = 0;
  late int itemsPerLine;

  @override
  void initState() {
    super.initState();
    setState(() {
      // widget.items.add('add');
      double itemSpace = widget.size + widget.space;
      itemsPerLine = widget.albumWidth ~/ itemSpace;
    });
  }

  @override
  Widget build(BuildContext context) {
    double left = 0;
    return SizedBox(
      child: widget.space >= 0
          ? Wrap(
              children: List.generate(
                widget.items.length,
                (index) => Padding(
                  padding: EdgeInsets.all(widget.space / 2),
                  child: widget.shape == AlbumShape.circle
                      ? CircleAvatar(
                          radius: widget.size / 2,
                          backgroundColor: widget.borderColor,
                          child: Center(
                            child: CircleAvatar(
                              radius: (widget.size - widget.borderWidth) / 2,
                              backgroundImage: AssetImage(
                                widget.items[index],
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: widget.size,
                          width: widget.size,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.borderColor,
                              width: widget.borderWidth,
                            ),
                          ),
                          child: Image.asset(
                            widget.items[index],
                          )),
                ),
              ),
            )
          : Wrap(
              children: List.generate(
                widget.items.length % itemsPerLine == 0
                    ? widget.items.length ~/ itemsPerLine
                    : widget.items.length ~/ itemsPerLine + 1,
                ((i) => SizedBox(
                      width: widget.albumWidth,
                      height: widget.size,
                      child: Stack(
                        children: List.generate(
                          widget.items.length % itemsPerLine == 0
                              ? itemsPerLine
                              : i < widget.items.length ~/ itemsPerLine
                                  ? itemsPerLine
                                  : widget.items.length % itemsPerLine,
                          (j) {
                            if (j == 0) {
                              left = 0;
                            }
                            if (j != 0) {
                              left = left + widget.size + widget.space;
                            }
                            return Positioned(
                              left: j == 0 ? 0 : left,
                              child: widget.shape == AlbumShape.circle
                                  ? widget.items[i *
                                                  widget.items.length ~/
                                                  widget.size +
                                              j] !=
                                          'add'
                                      ? CircleAvatar(
                                          radius: widget.size / 2,
                                          backgroundColor: widget.borderColor,
                                          child: Center(
                                            child: CircleAvatar(
                                              radius: (widget.size -
                                                      widget.borderWidth) /
                                                  2,
                                              backgroundImage: AssetImage(
                                                widget.items[i *
                                                        widget.items.length ~/
                                                        widget.size +
                                                    j],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          height: 20.0,
                                          width: 20.0,
                                          color: Colors.red,
                                        )
                                  : widget.items[i *
                                                  widget.items.length ~/
                                                  widget.size +
                                              j] !=
                                          'add'
                                      ? Container(
                                          height: widget.size,
                                          width: widget.size,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: widget.borderColor,
                                              width: widget.borderWidth,
                                            ),
                                          ),
                                          child: Image.asset(
                                            widget.items[i *
                                                    widget.items.length ~/
                                                    widget.size +
                                                j],
                                          ),
                                        )
                                      : Container(
                                          height: 20.0,
                                          width: 20.0,
                                          color: Colors.red,
                                        ),
                            );
                          },
                        ),
                      ),
                    )),
              ),
            ),
    );
  }
}

enum AlbumShape {
  circle,
  rect,
  square,
}

