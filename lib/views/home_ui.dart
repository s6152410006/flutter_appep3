import 'package:flutter/material.dart';
import 'package:flutter_app_ep3/models/myaccount.dart';
import 'package:flutter_app_ep3/utils/service_api.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeUI extends StatefulWidget {
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  Future<List<MyAccount>> futureMyAccount;

  getAllMyAccount() async {
    futureMyAccount = serviceGetAllMyAccount();
  }

  String changDateFormat(String dt){
    String year = dt.substring(0, 4);
    String month = dt.substring(5, 7);
    String day = dt.substring(8);

    year = (int.parse(year) + 543 ).toString();
    switch( int.parse(month)){
      case 1 : month = "มรกาคม"; break;
      case 2 : month = "กุมภา"; break;
      case 3 : month = "มีนาคม"; break;
      case 4 : month = "เมษายน"; break;
      case 5 : month = "พฤษภาคม"; break;
      case 6 : month = "มิถุนายน"; break;
      case 7 : month = "กรฏาคม"; break;
      case 8 : month = "สิงหาคม"; break;
      case 9 : month = "กันยายน"; break;
      case 10 : month = "ตุลาคม"; break;
      case 11 : month = "พฤศจิกายน"; break;
      default : month = "ธันวาคม";
    }
      return day + ' ' + month + ' พ.ศ.' + year;
  }

  @override
  void initState() {
    super.initState();
    getAllMyAccount();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Diary 2222',
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.lightGreen,
        icon: Icon(
          Icons.add,
        ),
        label: Text('เพิ่มข้อมูล'),
      ),
      body: futureMyAccount == null
          ? Center(
              child: Container(
                child: Text(''
                    'กรุราลองใหม่อีกครั้ง'),
                color: Colors.red,
              ),
            )
          : FutureBuilder<List<MyAccount>>(
              future: futureMyAccount,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    {
                      if(snapshot.hasData){
                        if(snapshot.data[0].message == '1'){
                          return ListView.separated(
                            separatorBuilder: (context, index){
                              return Container(
                                height: 2.0,
                                width: double.infinity,
                                color: Colors.lightGreenAccent,
                              );
                            },
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index){
                              return ListTile(
                                leading: CachedNetworkImage(
                                  imageUrl: '${urlService}/accountdiary${snapshot.data[index].mImage}',
                                  width: 50,
                                  height: 50,
                                  imageBuilder: (context, imageProvider){
                                    return Container(

                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                title: Text(
                                    '${snapshot.data[index].mName}',
                                ),
                                subtitle: Text(
                                  changDateFormat(snapshot.data[index].mDate),
                                    //'${snapshot.data[index].mDate}',
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward,
                                ),
                              );
                            },
                          );
                        }else if(snapshot.data[0].message == '2'){
                          return Center(
                            child: Container(
                              color: Colors.red,
                              child: Text(
                                'กรุณาลองใหม่อีกครั้ง....(A)',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          );
                        }else{
                          return Center(
                            child: Container(
                              color: Colors.red,
                              child: Text(
                                'กรุณาลองใหม่อีกครั้ง....(A4)',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          );
                        }
                      }else{
                        return Center(
                          child: Container(
                            color: Colors.red,
                            child: Text(
                              'กรุณาลองใหม่อีกครั้ง....(B)',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        );
                      }
                    }
                }
              }
              ),
    );
  }
}
