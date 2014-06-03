<%--
    Document   : index2
    Created on : Mar 3, 2013, 11:49:03 PM
    Author     : SANJU
--%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
        <title>JSP Page</title>
    </head>
    <body>
        <div id="map_canvas" style="width: 800px; height: 600px"></div> <div id="map2"></div>
        <h2>Double click on Map To Initialize Map</h2>
       
        <script type="text/javascript">
    var xmlHttp 
      var xmlHttp

    function showdept(){
      if (typeof XMLHttpRequest != "undefined"){
      xmlHttp= new XMLHttpRequest();
      }
      else if (window.ActiveXObject){
      xmlHttp= new ActiveXObject("Microsoft.XMLHTTP");
      }
      if (xmlHttp==null){
      alert("Browser does not support XMLHTTP Request")
      return;
      }
      var url="getdept.jsp";
     
      xmlHttp.onreadystatechange = listdept;
      xmlHttp.open("GET", url, true);
      xmlHttp.send(null);
      }

      function listdept(){  
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){  
      document.getElementById("dep").innerHTML=xmlHttp.responseText  
      }  
      }
     

</script>

       
        <script type="text/javascript">
            var gmarkers = [];
             var side_bar_html = "";
     var side_bar_html_top = "";
        
            var bounds = new google.maps.LatLngBounds();
            var latlng = new google.maps.LatLng(23.402800,78.454100);
            var options = {
        zoom: 15,
        center: latlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      }
       var map = new google.maps.Map(document.getElementById("map_canvas"), options);
      
function createMarker(point, number){
  
   
    number+="<table><tr><td>select Dep:</td><td><div id='dep'><select onclick='showdept()' >select<option >select</option></select></div></td></tr><input type='button' value='submit'><tr></tr></table>";
var marker = new google.maps.Marker({
          position:point ,
          map: map,
          raiseOnDrag: true,
          icon: "sa.jpg",
          animation:google.maps.Animation.DROP,
          draggable: false
        });
var html = number;
var infowindow = new google.maps.InfoWindow({
     content: html,
     maxwidth:999    
    });
    gmarkers.push(marker);
    side_bar_html += '<a href="javascript:myclick(' + (gmarkers.length-1) + ')">' + number + '<\/a><br>';
    google.maps.event.addListener(map, "click", function(event) {
       
        google.maps.event.addListener(marker, "click", function() {
          infowindow.open(map, marker);
        });
    });
   
return marker;
};
function myclick(i) {
        google.maps.event.trigger(gmarkers[i], 'click');
      
      }
        <%

    //String userName = "root";
    //String password = "";
    String url = "jdbc:db2://localhost:50000/SANJU";
    try{
        String driver ="com.ibm.db2.jcc.DB2Driver";
        Class.forName(driver).newInstance();
              
        Connection conn;
        conn = DriverManager.getConnection(url, "db2admin","000");
        Statement s = conn.createStatement();
        s.executeQuery ("SELECT * from SANJU.complain");
        ResultSet rs = s.getResultSet ();
        int count = 0;
        while (rs.next ()) {
                        String Date=rs.getString("date");
                              
            String lat = rs.getString ("latlon");
            String lon = rs.getString ("latlat");
            String det=rs.getString ("detail");
                        String add="<table><tr><td>Details:</td><td>"+det+"</td><td>Date:</td><td>"+Date+"</td></tr></table>";
                       
            out.print("var point = new google.maps.LatLng("+lat+","+lon+");\n");
            out.print("var marker = createMarker(point, '"+add+"');\n");
            //out.print("map.addOverlay(marker);\n");
                        out.print("document.getElementById('map2').innerHTML = side_bar_html;");
                        out.print("map.fitBounds(bounds);");
            out.print("\n");
        }
        rs.close ();
        s.close ();
    }
    catch(Exception ee){
        System.out.println(ee.toString());   
    }
%>
   
        </script>
       
       
       
       
       
    </body>
</html>