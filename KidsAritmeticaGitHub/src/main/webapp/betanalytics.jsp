<%@page import="playaddition.model.Suma"%>
<%@page import="java.util.*"%>
<%
String nivel =  (String) session.getAttribute("nivel");
String nombreImagen = "GoToLevel"+nivel+".png";
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  
  <title>PlayAddition</title>
 <script src="./js/json.js"></script>  
<script>
(function(w,d,s,g,js,fs){
  g=w.gapi||(w.gapi={});g.analytics={q:[],ready:function(f){this.q.push(f);}};
  js=d.createElement(s);fs=d.getElementsByTagName(s)[0];
  js.src='https://apis.google.com/js/platform.js';
  fs.parentNode.insertBefore(js,fs);js.onload=function(){g.load('analytics');};
}(window,document,'script'));
</script>


<script>
  // Replace with your view ID.
  var VIEW_ID = 'ga:189013339';

  // Query the API and print the results to the page.
  function queryReports() {
    gapi.client.request({
      path: '/v4/reports:batchGet',
      root: 'https://analyticsreporting.googleapis.com/',
      method: 'POST',
      body: {
        reportRequests: [
          {
            viewId: VIEW_ID,
            dateRanges: [
              {
                startDate: '7daysAgo',
                endDate: 'today'
              }
            ],
            metrics: [
              {
                expression: 'ga:sessions'
              }
            ]
          }
        ]
      }
    }).then(displayResults, console.error.bind(console));
  }

  function displayResults(response) {
    var formattedJson = JSON.stringify(response.result, null, 2);
    document.getElementById('query-output').value = formattedJson;
  }
</script>

<!-- Load the JavaScript API client and Sign-in library. -->
<script src="https://apis.google.com/js/client:platform.js"></script>




<script>

gapi.analytics.ready(function() {

  /**
   * Authorize the user with an access token obtained server side.
   */
  gapi.analytics.auth.authorize({
    'serverAuth': {
      'access_token': 'ya29.c.ElmmBg2d33KVKVaG2jU5WO-gXO3fFncx_JLgULJthpbR4eaYiIqxbjaLqFC2ajZYo6bMEq_HIjzm_PhF67cuoSVOsOiFeWW6iKXnsyUz32_g7d_8BzOGsk3phQ'
    }
  });
  
  
  


  /**
   * Creates a new DataChart instance showing sessions over the past 30 days.
   * It will be rendered inside an element with the id "chart-1-container".
   */
 /* var dataChart1 = new gapi.analytics.googleCharts.DataChart({
    query: {
      'ids': 'ga:189013339', // <-- Replace with the ids value for your view.
      'start-date': '2018-11-01',
      'end-date': 'yesterday',
      'metrics': 'ga:users'
    },
    chart: {
      'container': 'chart-1-container',
      'type': 'LINE',
      'options': {
        'width': '100%'
      }
    }
  });
  dataChart1.execute();*/
  
  
  
  /*var report = new gapi.analytics.report.Data({
	  query: {
		  'ids': 'ga:189013339', // <-- Replace with the ids value for your view.
	      'start-date': '2018-11-01',
	      'end-date': 'yesterday',
	      'metrics': 'ga:users'
	  }
	});

	report.on('success', handleReportingResults);

	report.execute();*/
	
	
	
	new gapi.client.analyticsreporting.reports.batchGet( {
		  "reportRequests":[
		  {
		    "viewId":"ga:189013339",
		    "dateRanges":[
		      {
		        "startDate":"2018-11-01",
		        "endDate":"yesterday"
		      }],
		    "metrics":[
		      {
		        "expression":"ga:users"
		      }]
		  }]
		} ).execute(handleReportingResults)
	
	
	function handleReportingResults(response) {
		alert(response);
		  if (!response.code) {
		    
		    for( var i = 0, report; report = response.reports[ i ]; ++i )
		    {
		      if (report.data.rows && report.data.rows.length) {
		        var table = ['<table>'];

		        // Put headers in table.
		        table.push('<tr><th>', report.columnHeader.dimensions.join('</th><th>'), '</th>');
		        table.push('<th>Date range #</th>');

		        for (var i=0, header; header = report.columnHeader.metricHeader.metricHeaderEntries[i]; ++i) {
		          table.push('<th>', header.name, '</th>');
		        }

		        table.push('</tr>');

		        // Put cells in table.
		        for (var rowIndex=0, row; row = report.data.rows[rowIndex]; ++rowIndex) {
		          for(var dateRangeIndex=0, dateRange; dateRange = row.metrics[dateRangeIndex]; ++dateRangeIndex) {
		            // Put dimension values
		            table.push('<tr><td>', row.dimensions.join('</td><td>'), '</td>');
		            // Put metric values for the current date range
		            table.push('<td>', dateRangeIndex, '</td><td>', dateRange.values.join('</td><td>'), '</td></tr>');
		          }
		        }
		        table.push('</table>');
				alert(""+table);
		        document.getElementById("chart-1-container").innerHTML = ""+table;
		      }
		    }
		    

		  
		}
	}


  /**
   * Creates a new DataChart instance showing top 5 most popular demos/tools
   * amongst returning users only.
   * It will be rendered inside an element with the id "chart-3-container".
   */
  /*var dataChart2 = new gapi.analytics.googleCharts.DataChart({
    query: {
      'ids': 'ga:189013339', // <-- Replace with the ids value for your view.
      'start-date': '30daysAgo',
      'end-date': 'yesterday',
      'metrics': 'ga:pageviews',
      'dimensions': 'ga:pagePathLevel1',
      'sort': '-ga:pageviews',
      'filters': 'ga:pagePathLevel1!=/',
      'max-results': 7
    },
    chart: {
      'container': 'chart-2-container',
      'type': 'PIE',
      'options': {
        'width': '100%',
        'pieHole': 4/9,
      }
    }
  });
  dataChart2.execute();*/
  
  
  /**
   * Create a new ViewSelector instance to be rendered inside of an
   * element with the id "view-selector-container".
   */
 /* var viewSelector = new gapi.analytics.ViewSelector({
    container: 'view-selector-container'
  });

  // Render the view selector to the page.
  viewSelector.execute();*/


  /**
   * Create a new DataChart instance with the given query parameters
   * and Google chart options. It will be rendered inside an element
   * with the id "chart-container".
   */
  /*var dataChart = new gapi.analytics.googleCharts.DataChart({
    query: {
      'ids': 'ga:189013339',
      'metrics': 'ga:sessions',
      'dimensions': 'ga:date',
      'start-date': '30daysAgo',
      'end-date': 'yesterday'
    },
    chart: {
      container: 'chart-container',
      type: 'LINE',
      options: {
        width: '100%'
      }
    }
  });


  /**
   * Render the dataChart on the page whenever a new view is selected.
   */
  /*viewSelector.on('change', function(ids) {
    dataChart.set({query: {ids: ids}}).execute();
  });*/
  
  
  
  
  

});
</script>
  
</head>

  <body>
 	<div id="chart-1-container"></div>
	<div id="chart-2-container"></div>
	<div id="chart-container"></div>
	<div id="view-selector-container"></div>
  </body>
</html>