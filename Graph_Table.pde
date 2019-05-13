import processing.serial.*;
import grafica.*;

GPlot plot1;

Serial myPort;
Table table;
String filename;
int j;
float[] inputy;
//float[] inputx;
int XXX=0;


void setup()
{
  size(600, 600);
  background(0);
  myPort = new Serial(this, Serial.list()[0], 9600);
  table = new Table();
  //add a column header "Data" for the collected data
  table.addColumn("Data");
  //add a column header "Time" and "Date" for a timestamp to each data entry
  table.addColumn("Time");
  //table.addColumn("Date");
  createPlot();
}

void draw()
{
  if (XXX==0) {
    loadData();
    XXX=1;
  }
}



void keyPressed()
{
  //variables used for the filename timestamp
  //int h = hour();
  //int min = minute();
  //int s = second();

  //filename = "data/" + "Table--" + str(h) + "-" + str(min) + "-" + str(s) + ".csv";
  //save as a table in csv format(data/table - data folder name table)
  filename = "data/" + "Table" + ".csv";
  saveTable(table, filename);
}


void loadData() {

  table = loadTable("Table.csv", "header");
  inputy = new float[table.getRowCount()]; 
  // You can access iterate over all the rows in a table
  for (int j = 0; j < table.getRowCount(); j++) {
    TableRow row = table.getRow(j);
    // You can access the fields via their column name (or index)
    inputy[j]  = row.getFloat("Data");
    //inputx[j]  = row.getFloat("Time");
  }
}

void createTable() {

  //variables called each time a new data entry is received
  //int d = day();
  //int m = month();
  //int y = year();
  int h = hour();
  int min = minute();
  int s = second();

  if (myPort.available() > 0)
  {
    //set the value recieved as a String
    String value = myPort.readString();
    if (value != null)
    {
      //add a new row for each value
      TableRow newRow = table.addRow();
      //place the new row and value under the "Data" column
      newRow.setString("Data", value + "  ");
      newRow.setString("Time", str(h) + ":" + str(min) + ":" + str(s));
      //newRow.setString("Date", str(d) + "/" + str(m) + "/" + str(y));
    }
  }
}

void createPlot() {

  plot1 = new GPlot(this);  //initializing the object plot1
  plot1.setPos(width/10, height/10); //set position of the plot (x,y)
  plot1.setOuterDim(width/2-10, height-10); //set the outer dimension of the plot (width, height)
  plot1.setDim(2*width/3-10, 2*height/3-10); //set the inner dimension of the plot (width, height)
  plot1.setTitleText("DATA"); //set the title of the plot
  plot1.getXAxis().setAxisLabelText("X"); //set x-axis label
  plot1.getYAxis().setAxisLabelText("Y");//set y-axis label
  plot1.defaultDraw(); //draw the plot!
}

//void drawGraphic () {

//if (flag==1)
//{ //when a data from the serial port is available
// points.add(counter, float(val_in));  //add this data to the array of points "points"
//    counter++; //increment the index of the array
//  if (counter>=n_sample_array) //when the array is full (100 points) ...
//  points.remove(0); //...remove the first point
//    plot1.setPoints(points); //add the points to the plot
//  plot1.defaultDraw(); //draw the plot!
//flag=0; // reset the flag that advises the draw function that a new data is available on the Serial port
//}
//}
