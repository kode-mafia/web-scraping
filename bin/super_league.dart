import 'dart:convert';

import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class Scraper{
  static const URL = 'https://goalnepal.com/tournament/55';
 
  static void getData() async{
    final data={};
    final response = await http.get(Uri.parse(URL));
    final body = response.body;
    final html = parse(body);
    
    //get the title of the page
    final title = html.querySelector('.page-title')!.text;
    data['title'] = title;

    // get the name of the teams
    final teams = html.querySelectorAll('.row > .club-list');
    data['teams'] = [];
    for (var team in teams){
      data['teams'].add(team.text.trim());

      //get player name
      final playersTable = html.querySelectorAll('.fixtures')[2];
      final playersTableRow = playersTable.querySelectorAll('tr');
      data['players'] = [];
      for (var row in playersTableRow){
        final rowData = row.querySelectorAll('td');
        if(rowData.isNotEmpty){
          data['players'].add(rowData[1].text.trim());
        }
      } 
    }
    print(jsonEncode(data));
  }
}

void main(List<String> arguments) {
Scraper.getData();
}
