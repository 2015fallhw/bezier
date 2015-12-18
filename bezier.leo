<?xml version="1.0" encoding="utf-8"?>
<!-- Created by Leo: http://leoeditor.com/leo_toc.html -->
<?xml-stylesheet ekr_test ?>
<leo_file xmlns:leo="http://leoeditor.com/namespaces/leo-python-editor/1.1" >
<leo_header file_format="2" tnodes="0" max_tnode_index="0" clone_windows="0"/>
<globals body_outline_ratio="0.5" body_secondary_ratio="0.5">
	<global_window_position top="50" left="50" height="500" width="700"/>
	<global_log_window_position top="0" left="0" height="0" width="0"/>
</globals>
<preferences/>
<find_panel_settings/>
<vnodes>
<v t="leo.20151218135652.1"><vh>@settings</vh>
<v t="leo.20151218135652.2"><vh>@data qt-gui-plugin-style-sheet</vh></v>
<v t="leo.20151218135652.3"><vh>@string initial_split_orientation = horizontal</vh></v>
</v>
<v t="leo.20151218173801.1"><vh>@edit index.html</vh></v>
<v t="leo.20151218164302.1"><vh>@edit brython.html</vh></v>
<v t="leo.20151218170053.1"><vh>@path lib</vh>
<v t="leo.20151218170101.1"><vh>@edit bezier.js</vh></v>
</v>
<v t="leo.20151218170625.1"><vh>@path js</vh>
<v t="leo.20151218170632.1"><vh>@edit draw.js</vh></v>
</v>
<v t="leo.20151218173614.1"><vh>draw.js</vh></v>
</vnodes>
<tnodes>
<t tx="leo.20151218135652.1"></t>
<t tx="leo.20151218135652.2">QTreeWidget {
    /* These apply to the selected item, but not to editing items.*/
    background-color: #ffffec; /* Leo's traditional tree color */
    selection-color: black; /* was white */
    selection-background-color: lightgrey;
    /* font-family: SansSerif; */
    /*font-family: DejaVu Sans Mono;*/
    font-family:YaHei Mono;
    /* 標題字型大小設定 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal, italic,oblique */
 }

/* Headline edit widgets */
QTreeWidget QLineEdit {
    background-color: cornsilk;
    selection-color: white;
    selection-background-color: blue;
    /*font-family: DejaVu Sans Mono;*/    
    font-family:YaHei Mono;
    /* 沒有特別對應字型大小 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal, italic,oblique */
}

/* The log panes */
QTextEdit {
    background-color: #f2fdff;
    selection-color: red;
    selection-background-color: blue;
    /* font-family: Courier New; */
    font-family:YaHei Mono;
    /* log font 大小 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal, italic,oblique */
}

/* The body pane */
QTextEdit#richTextEdit {
    background-color: #fdf5f5; /* A kind of pink. */
    selection-color: white;
    selection-background-color: red;
    /*font-family: DejaVu Sans Mono;*/
    /* font-family: Courier New; */
    font-family:YaHei Mono;
    /* 內文字型大小 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
}

QLabel {
    font-family:YaHei Mono;'CherryPy', 'pytz', 'mako', 'beautifulsoup4', 'pymysql', 'peewee'
    /* 下方的 Minibuffer 標題字型大小 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
}

/* Editor labels */
QLineEdit#editorLabel {
    background-color: #ffffec;
    font-family:YaHei Mono;
    /* 沒有直接對應字型大小 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
    border: 2px;
    margin: 2px;
}</t>
<t tx="leo.20151218135652.3">horizontal: body pane to the left
vertical: body pane on the botton</t>
<t tx="leo.20151218170053.1"></t>
<t tx="leo.20151218170625.1"></t>
<t tx="leo.20151218173614.1">function bindDrawFunctions(idx) {

  var figure = find("figure")[idx];
  var cvs = document.createElement("canvas");
  cvs.width = 200;
  cvs.height = 200;
  var ctx = cvs.getContext("2d");
  figure.appendChild(cvs);
  var button = figure.querySelector("button");
  if(button) { figure.appendChild(button); }

  return {
    getCanvas: function() { return cvs; },

    reset: function() {
      cvs.width = cvs.width;
      ctx.strokeStyle = "black";
      ctx.fillStyle = "none";
    },

    setColor: function(c) {
      ctx.strokeStyle = c;
    },

    noColor: function(c) {
      ctx.strokeStyle = "transparent";
    },

    setRandomColor: function() {
      var r = ((255*Math.random())|0),
          g = ((255*Math.random())|0),
          b = ((255*Math.random())|0);
      ctx.strokeStyle = "rgb("+r+","+g+","+b+")";
    },

    setRandomFill: function(a) {
      a = (typeof a === "undefined") ? 1 : a;
      var r = ((255*Math.random())|0),
          g = ((255*Math.random())|0),
          b = ((255*Math.random())|0);
      ctx.fillStyle = "rgba("+r+","+g+","+b+","+a+")";
    },

    setFill: function(c) {
      ctx.fillStyle = c;
    },

    noFill: function() {
      ctx.fillStyle = "transparent";
    },

    drawSkeleton: function(curve, offset) {
      offset = offset || { x:0, y:0 };
      var pts = curve.points;
      ctx.strokeStyle = "lightgrey";
      this.drawLine(pts[0], pts[1], offset);
      if(pts.length === 3) { this.drawLine(pts[1], pts[2], offset); }
      else {this.drawLine(pts[2], pts[3], offset); }
      ctx.strokeStyle = "black";
      this.drawPoints(pts, offset);
    },

    drawCurve: function(curve, offset) {
      offset = offset || { x:0, y:0 };
      var ox = offset.x;
      var oy = offset.y;
      ctx.beginPath();
      var p = curve.points, i;
      ctx.moveTo(p[0].x + ox, p[0].y + oy);
      if(p.length === 3) {
        ctx.quadraticCurveTo(
          p[1].x + ox, p[1].y + oy,
          p[2].x + ox, p[2].y + oy
        );
      }
      if(p.length === 4) {
        ctx.bezierCurveTo(
          p[1].x + ox, p[1].y + oy,
          p[2].x + ox, p[2].y + oy,
          p[3].x + ox, p[3].y + oy
        );
      }
      ctx.stroke();
      ctx.closePath();
    },

    drawLine: function(p1, p2, offset) {
      offset = offset || { x:0, y:0 };
      var ox = offset.x;
      var oy = offset.y;
      ctx.beginPath();
      ctx.moveTo(p1.x + ox,p1.y + oy);
      ctx.lineTo(p2.x + ox,p2.y + oy);
      ctx.stroke();
    },

    drawPoint: function(p, offset) {
      offset = offset || { x:0, y:0 };
      var ox = offset.x;
      var oy = offset.y;
      ctx.beginPath();
      ctx.arc(p.x + ox, p.y + oy, 5, 0, 2*Math.PI);
      ctx.stroke();
    },

    drawPoints: function(points, offset) {
      offset = offset || { x:0, y:0 };
      points.forEach(function(p) {
        this.drawCircle(p, 3, offset);
      }.bind(this));
    },

    drawArc: function(p, offset) {
      offset = offset || { x:0, y:0 };
      var ox = offset.x;
      var oy = offset.y;
      ctx.beginPath();
      ctx.moveTo(p.x + ox, p.y + oy);
      ctx.arc(p.x + ox, p.y + oy, p.r, p.s, p.e);
      ctx.lineTo(p.x + ox, p.y + oy);
      ctx.fill();
      ctx.stroke();
    },

    drawCircle: function(p, r, offset) {
      offset = offset || { x:0, y:0 };
      var ox = offset.x;
      var oy = offset.y;
      ctx.beginPath();
      ctx.arc(p.x + ox, p.y + oy, r, 0, 2*Math.PI);
      ctx.stroke();
    },

    drawbbox: function(bbox, offset) {
      offset = offset || { x:0, y:0 };
      var ox = offset.x;
      var oy = offset.y;
      ctx.beginPath();
      ctx.moveTo(bbox.x.min + ox, bbox.y.min + oy);
      ctx.lineTo(bbox.x.min + ox, bbox.y.max + oy);
      ctx.lineTo(bbox.x.max + ox, bbox.y.max + oy);
      ctx.lineTo(bbox.x.max + ox, bbox.y.min + oy);
      ctx.closePath();
      ctx.stroke();
    },

    drawShape: function(shape, offset) {
      offset = offset || { x:0, y:0 };
      var order = shape.forward.points.length - 1;
      ctx.beginPath();
      ctx.moveTo(offset.x + shape.startcap.points[0].x, offset.y + shape.startcap.points[0].y);
      ctx.lineTo(offset.x + shape.startcap.points[3].x, offset.y + shape.startcap.points[3].y);
      if(order === 3) {
        ctx.bezierCurveTo(
          offset.x + shape.forward.points[1].x, offset.y + shape.forward.points[1].y,
          offset.x + shape.forward.points[2].x, offset.y + shape.forward.points[2].y,
          offset.x + shape.forward.points[3].x, offset.y + shape.forward.points[3].y
        );
      } else {
        ctx.quadraticCurveTo(
          offset.x + shape.forward.points[1].x, offset.y + shape.forward.points[1].y,
          offset.x + shape.forward.points[2].x, offset.y + shape.forward.points[2].y
        );
      }
      ctx.lineTo(offset.x + shape.endcap.points[3].x, offset.y + shape.endcap.points[3].y);
      if(order === 3) {
        ctx.bezierCurveTo(
          offset.x + shape.back.points[1].x, offset.y + shape.back.points[1].y,
          offset.x + shape.back.points[2].x, offset.y + shape.back.points[2].y,
          offset.x + shape.back.points[3].x, offset.y + shape.back.points[3].y
        );
      } else {
        ctx.quadraticCurveTo(
          offset.x + shape.back.points[1].x, offset.y + shape.back.points[1].y,
          offset.x + shape.back.points[2].x, offset.y + shape.back.points[2].y
        );
      }
      ctx.closePath();
      ctx.fill();
      ctx.stroke();
    },

    drawText: function(text, offset) {
      offset = offset || { x:0, y:0 };
      ctx.fillText(text, offset.x, offset.y);
    }
  };
}
</t>
</tnodes>
</leo_file>
