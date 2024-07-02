import 'package:flutter/material.dart';
import 'package:easy_web_view/easy_web_view.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class WazuhManger extends StatefulWidget {
  const WazuhManger({super.key});

  @override
  State<WazuhManger> createState() => _WazuhMangerState();
}

//make empty page for wazuh manager
class _WazuhMangerState extends State<WazuhManger> {
  
/*
WebView(src: "https://10.10.10.2/app/dashboards#/view/965badb0-fd6c-11ee-9b2a-399f99f47f42?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-24h,to:now))&_a=(description:'',filters:!(),fullScreenMode:!f,options:(hidePanelTitles:!f,useMargins:!t),query:(language:kuery,query:''),timeRestore:!f,title:'test1%20-%20Manager%20and%20Agents%20info',viewMode:view)"),
                  WebView(src: "https://10.10.10.2/app/dashboards#/view/f1a4dc40-fd6d-11ee-9b2a-399f99f47f42?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-24h,to:now))&_a=(description:'',filters:!(),fullScreenMode:!f,options:(hidePanelTitles:!f,useMargins:!t),query:(language:kuery,query:''),timeRestore:!f,title:'test2%20-%20Alerts',viewMode:view)"),
                  WebView(src: "https://10.10.10.2/app/dashboards#/view/92278f00-fd6e-11ee-9b2a-399f99f47f42?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-24h,to:now))&_a=(description:'',filters:!(),fullScreenMode:!f,options:(hidePanelTitles:!f,useMargins:!t),query:(language:kuery,query:''),timeRestore:!f,title:'test3%20-%20Alerts%20graphs',viewMode:view)"),
                  WebView(src: "https://10.10.10.2/app/dashboards#/view/a3be0d50-fd70-11ee-9b2a-399f99f47f42?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-24h,to:now))&_a=(description:'',filters:!(),fullScreenMode:!f,options:(hidePanelTitles:!f,useMargins:!t),query:(language:kuery,query:''),timeRestore:!f,title:'test4%20-%20Alerts%20(Advanced)',viewMode:view)"),
                  WebView(src: "https://10.10.10.2/app/dashboards#/view/cd4b2900-fd75-11ee-9b2a-399f99f47f42?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-24h,to:now))&_a=(description:'',filters:!(),fullScreenMode:!f,options:(hidePanelTitles:!f,useMargins:!t),query:(language:kuery,query:''),timeRestore:!f,title:'test5%20-%20Malicious%20traffic',viewMode:view)"),
                  WebView(src: "https://10.10.10.2/app/dashboards#/view/a1bcb490-ff1c-11ee-9b2a-399f99f47f42?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-24h,to:now))&_a=(description:'',filters:!(),fullScreenMode:!f,options:(hidePanelTitles:!f,useMargins:!t),query:(language:kuery,query:''),timeRestore:!f,title:'test6%20-%20Advanced%20Firewall',viewMode:view)"),
                  WebView(src: "https://10.10.10.2/app/dashboards#/view/fa680280-fd77-11ee-9b2a-399f99f47f42"),
                  WebView(src: "https://10.10.10.2/app/dashboards#/view/a5b2bbf0-fd71-11ee-9b2a-399f99f47f42"),
                  WebView(src: "https://10.10.10.2/app/dashboards#/view/81fe50c0-fd76-11ee-9b2a-399f99f47f42"),
                  WebView(src: "https://10.10.10.2/app/dashboards#/view/42bfefa0-fd75-11ee-9b2a-399f99f47f42"),
                  WebView(src: "https://10.10.10.2/app/dashboards#/view/bd63bd70-fd77-11ee-9b2a-399f99f47f42")  
   
  final List<String> _pages = [
    "Manager and Agents info",
    "Alerts",
    "Alerts graphs",
    "Alerts (Advanced)",
    "Malicious traffic",
    "Advanced Firewall",
    "Live traffic",
    "Vulnerabilities",
    "Domains",
    "Files",
    "Decoders and MITRE"

  ];

 */

  
  final List<String> _pages = [
    "Manager and Agents info",
    "Alerts",
    "Alerts graphs",
    "Alerts (Advanced)",
    "Malicious traffic",
    "Advanced Firewall",
    "Live traffic",
    "Vulnerabilities",
    "Domains",
    "Files",
    "Decoders and MITRE"
    
  ];
  
  String _selectedPage = "Manager and Agents info";
  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40), // Rounded edges
      child: Container(
        //height: MediaQuery.of(context).size.height, // Adjust the height as needed
        //width: MediaQuery.of(context).size.width, // Adjust the width as needed
        child: Column(
          children: [

           
            Container(
              height: 50,
              color: Color(0xFF4F90B5),
              child: Row(
                 children:[
                  
                  SizedBox(width: 250),

                    DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            items: _pages
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF14141F),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: _selectedPage,
            onChanged: (String? value) {
              setState(() {
                _selectedPage = value!;
                _selectedIndex = _pages.indexOf(value);
              });
            },
            buttonStyleData: ButtonStyleData(
              height: 40,
              width: 600,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
                color:  Colors.white,
              ),
              elevation: 2,
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
              ),
              iconSize: 20,
              iconEnabledColor: Colors.black,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: 600,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:  Colors.white,
              ),
              offset: const Offset(0, 40),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all<double>(6),
                thumbVisibility: MaterialStateProperty.all<bool>(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        ),

        //make qustion white mark icon
        const SizedBox(width: 200),
        const Icon(
          Icons.info_outline,
          color: Colors.white,
          size: 30,
        ),
        
          ],
        ),
            ),
            
               Expanded(
                 child: IndexedStack(
                           index: _selectedIndex,
                              children: [ 
                              //empty container
                           /*    Container(
                                child: const Text("Main Dashboard"),
                              ),
                              Container(
                                child: const Text("Manager and Agents info"),
                              ),
                              Container(
                                child: const Text("Alerts"),
                              ),
                              Container(
                                child: const Text("Alerts graphs"),
                              ),
                              Container(
                                child: const Text("Malicious traffic"),
                              ),
                               */
                  WebView(src: "https://10.10.10.2/app/dashboards#/view/965badb0-fd6c-11ee-9b2a-399f99f47f42?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-24h,to:now))&_a=(description:'',filters:!(),fullScreenMode:!f,options:(hidePanelTitles:!f,useMargins:!t),query:(language:kuery,query:''),timeRestore:!f,title:'test1%20-%20Manager%20and%20Agents%20info',viewMode:view)"),
                  WebView(src: "https://10.10.10.2/app/dashboards#/view/f1a4dc40-fd6d-11ee-9b2a-399f99f47f42?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-24h,to:now))&_a=(description:'',filters:!(),fullScreenMode:!f,options:(hidePanelTitles:!f,useMargins:!t),query:(language:kuery,query:''),timeRestore:!f,title:'test2%20-%20Alerts',viewMode:view)"),
                  WebView(src: "https://10.10.10.2/app/dashboards#/view/92278f00-fd6e-11ee-9b2a-399f99f47f42?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-24h,to:now))&_a=(description:'',filters:!(),fullScreenMode:!f,options:(hidePanelTitles:!f,useMargins:!t),query:(language:kuery,query:''),timeRestore:!f,title:'test3%20-%20Alerts%20graphs',viewMode:view)"),
                  WebView(src: "https://10.10.10.2/app/dashboards#/view/a3be0d50-fd70-11ee-9b2a-399f99f47f42?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-24h,to:now))&_a=(description:'',filters:!(),fullScreenMode:!f,options:(hidePanelTitles:!f,useMargins:!t),query:(language:kuery,query:''),timeRestore:!f,title:'test4%20-%20Alerts%20(Advanced)',viewMode:view)"),
                  WebView(src: "https://10.10.10.2/app/dashboards#/view/cd4b2900-fd75-11ee-9b2a-399f99f47f42?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-24h,to:now))&_a=(description:'',filters:!(),fullScreenMode:!f,options:(hidePanelTitles:!f,useMargins:!t),query:(language:kuery,query:''),timeRestore:!f,title:'test5%20-%20Malicious%20traffic',viewMode:view)"),
                  WebView(src: "https://10.10.10.2/app/dashboards#/view/a1bcb490-ff1c-11ee-9b2a-399f99f47f42?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-24h,to:now))&_a=(description:'',filters:!(),fullScreenMode:!f,options:(hidePanelTitles:!f,useMargins:!t),query:(language:kuery,query:''),timeRestore:!f,title:'test6%20-%20Advanced%20Firewall',viewMode:view)"),
                  WebView(src: "https://10.10.10.2/app/dashboards#/view/fa680280-fd77-11ee-9b2a-399f99f47f42"),
                  WebView(src: "https://10.10.10.2/app/dashboards#/view/a5b2bbf0-fd71-11ee-9b2a-399f99f47f42"),
                  WebView(src: "https://10.10.10.2/app/dashboards#/view/81fe50c0-fd76-11ee-9b2a-399f99f47f42"),
                  WebView(src: "https://10.10.10.2/app/dashboards#/view/42bfefa0-fd75-11ee-9b2a-399f99f47f42"),
                  WebView(src: "https://10.10.10.2/app/dashboards#/view/bd63bd70-fd77-11ee-9b2a-399f99f47f42")  
   
 

                              ],
                         ),
               ),
          ],
        ),
      ),
    );
  }
}

//web view widget

class WebView extends StatefulWidget {
  final String src;
  WebView({required this.src});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  @override
  Widget build(BuildContext context) {
    return EasyWebView(
      src: widget.src,
      //isHtml: false,
      isMarkdown: false,
      convertToWidgets: false,
    );
  }
}

