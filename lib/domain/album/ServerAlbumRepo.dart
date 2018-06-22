import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hud/domain/album/AlbumDto.dart';
import 'package:http/http.dart' as http;

class ServerAlbumRepo extends AlbumRepo {
  final _ServerDomain = "http://amazingdomain.net/";
  final _AlbumDirectory = "albums";
  final _AlbumKspUrl =
      "album/customrss?url=https://www.reddit.com/r/KerbalSpaceProgram/.rss";

  @override
  List<AlbumDto> getAlbumList() {
    debugPrint("Hello log world");
    List list = new List<AlbumDto>();

    list.add(new AlbumDto(
        thumbnail: "https://i.redd.it/ozbl5p8jmf511.jpg",
        niceName: "Test album 1"));

    return list;
  }

  @override
  Future<List<AlbumDto>> getAlbumListAsync() async {
    var response = await http.get('${_ServerDomain}${_AlbumDirectory}');
    final json = JSON.decode(response.body);

    return AlbumDto.listFromJson(json);
  }
}

abstract class AlbumRepo {
  List<AlbumDto> getAlbumList();

  Future<List<AlbumDto>> getAlbumListAsync();
}
