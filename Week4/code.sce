function draw_system (an, bm, opt)
    loadXcosLibs();
    scs_m = scicos_diagram();
    scs_m.props.title = "Diagram";
    if (opt == 0) then
        index = 0
        // x(n)
        index = index + 1
        scs_m.objs(index) = CONST("define");
        scs_m.objs(index).graphics.exprs = "x(n)";
        scs_m.objs(index).graphics.orig = [100, 50]; 
        
        // Z^-1
        for i = 1:length(bm) - 1
            index = index + 1
            scs_m.objs(index) = DELAY_f("define");
            scs_m.objs(index).graphics.orig = [200, -10 - (i-1)*120];
            scs_m.objs(index).graphics.style = "Z;rotation=90"
            scs_m.objs(index).graphics.in_style = "ExplicitInputPort;align=center;verticalAlign=top;spacing=10.0;rotation=90"
            scs_m.objs(index).graphics.out_style= "ExplicitOutputPort;align=center;verticalAlign=bottom;spacing=10.0;rotation=90"
            
            index = index + 1
            scs_m.objs(index) = TEXT_f("define");
            scs_m.objs(index).graphics.orig = [200,  - (i-1)*120];
            scs_m.objs(index).graphics.exprs = ["Z^-1";"2";"1"]
        end
        
        // triangle 1
        for i = 1:length(bm)
            index = index + 1
            scs_m.objs(index) = SQRT("define");
            scs_m.objs(index).graphics.style = "shape=triangle";
            scs_m.objs(index).graphics.orig = [350, 50 - (i-1)*120];
            
            index = index + 1
            scs_m.objs(index) = TEXT_f("define");
            scs_m.objs(index).graphics.orig = [345, 60 - (i-1)*120];
            scs_m.objs(index).graphics.exprs = [string(bm(1,i));"2";"1"]
        end
         
         
        // sum 1
        index = index + 1
        scs_m.objs(index) = SUM_f("define");
        scs_m.objs(index).graphics.pin = [0;0];
        scs_m.objs(index).graphics.in_implicit = ["E", "E"];
        scs_m.objs(index).graphics.orig = [500, 60]; 
        scs_m.objs(index).graphics.in_style= ["ExplicitInputPort;align=center;verticalAlign=bottom;spacing=10.0;rotation=270";"ExplicitInputPort;align=left;verticalAlign=middle;spacing=10.0;rotation=0"]
        scs_m.objs(index).graphics.out_style= "ExplicitOutputPort;align=right;verticalAlign=middle;spacing=10.0;rotation=0"
        scs_m.objs(index).graphics.style= "SUM_f;flip=false"
        
        for i = 2:length(bm) - 1
            index = index + 1
            scs_m.objs(index) = SUM_f("define");
            scs_m.objs(index).graphics.pin = [0;0];
            scs_m.objs(index).graphics.in_implicit = ["E", "E"];
            scs_m.objs(index).graphics.orig = [500, 60 - (i-1)*120]; 
            scs_m.objs(index).graphics.in_style= ["ExplicitInputPort;align=left;verticalAlign=middle;spacing=10.0;rotation=0";"ExplicitInputPort;align=center;verticalAlign=bottom;spacing=10.0;rotation=270"]
            scs_m.objs(index).graphics.out_style= "ExplicitOutputPort;align=center;verticalAlign=top;spacing=10.0;rotation=270"
            scs_m.objs(index).graphics.style= "SUM_f;rotation=90;mirror=true"
        end
        
        // sum 2
        index = index + 1
        scs_m.objs(index) = SUM_f("define");
        scs_m.objs(index).graphics.pin = [0;0];
        scs_m.objs(index).graphics.in_implicit = ["E", "E"];
        scs_m.objs(index).graphics.orig = [600, 60]; 
        scs_m.objs(index).graphics.in_style= ["ExplicitInputPort;align=center;verticalAlign=bottom;spacing=10.0;rotation=270";"ExplicitInputPort;align=left;verticalAlign=middle;spacing=10.0;rotation=0"]
        scs_m.objs(index).graphics.out_style= "ExplicitOutputPort;align=right;verticalAlign=middle;spacing=10.0;rotation=0"
        scs_m.objs(index).graphics.style= "SUM_f;flip=false"
            
        for i = 2:length(an) 
            index = index + 1
            scs_m.objs(index) = SUM_f("define");
            scs_m.objs(index).graphics.pin = [0;0];
            scs_m.objs(index).graphics.in_implicit = ["E", "E"];
            scs_m.objs(index).graphics.orig = [600, 60 - (i-1)*120]; 
            scs_m.objs(index).graphics.in_style= ["ExplicitInputPort;align=right;verticalAlign=middle;spacing=10.0;rotation=180";"ExplicitInputPort;align=center;verticalAlign=bottom;spacing=10.0;rotation=270"]
            scs_m.objs(index).graphics.out_style= "ExplicitOutputPort;align=center;verticalAlign=top;spacing=10.0;rotation=270"
            scs_m.objs(index).graphics.style= "SUM_f;rotation=90;flip=true;mirror=true"
        end
        
        // triangle 2
        for i = 2:length(an)+1
            index = index + 1
            scs_m.objs(index) = SQRT("define");
            scs_m.objs(index).graphics.style = "shape=triangle";
            scs_m.objs(index).graphics.orig = [720, 50 - (i-1)*120];
            scs_m.objs(index).graphics.in_style= "ExplicitInputPort;align=right;verticalAlign=middle;spacing=10.0;rotation=180"
            scs_m.objs(index).graphics.out_style= "ExplicitOutputPort;align=left;verticalAlign=middle;spacing=10.0;rotation=180"
            scs_m.objs(index).graphics.style= "shape=triangle;flip=false;mirror=true"
            
            index = index + 1
            scs_m.objs(index) = TEXT_f("define");
            scs_m.objs(index).graphics.orig = [725, 60 - (i-1)*120];
            scs_m.objs(index).graphics.exprs = [string(an(1,i-1));"2";"1"]
        end
        
        
        // Z^-1
        for i = 1:length(an) 
            index = index + 1
            scs_m.objs(index) = DELAY_f("define");
            scs_m.objs(index).graphics.orig = [850, -10 - (i-1)*120];
            scs_m.objs(index).graphics.style = "Z;rotation=90"
            scs_m.objs(index).graphics.in_style = "ExplicitInputPort;align=center;verticalAlign=top;spacing=10.0;rotation=90"
            scs_m.objs(index).graphics.out_style= "ExplicitOutputPort;align=center;verticalAlign=bottom;spacing=10.0;rotation=90"
            
            index = index + 1
            scs_m.objs(index) = TEXT_f("define");
            scs_m.objs(index).graphics.orig = [850,  - (i-1)*120];
            scs_m.objs(index).graphics.exprs = ["Z^-1";"2";"1"]
        end
        
        // y(n)
        index = index + 1
        scs_m.objs(index) = CONST_m("define");
        scs_m.objs(index).graphics.exprs = "y(n)";
        scs_m.objs(index).graphics.pin = 5;
        scs_m.objs(index).graphics.pout = [];
        scs_m.objs(index).graphics.out_implicit = [];
        scs_m.objs(index).graphics.in_implicit = "E";
        scs_m.objs(index).graphics.out_style = "";
        scs_m.objs(index).in_style = "ExplicitInputPort;align=left;verticalAlign=middle;spacing=10.0"
        scs_m.objs(index).graphics.orig = [950, 50]; 
        
        // link Z^-1 vertically
        start1 = 2
        for i = 1:length(bm)-2
            index = index + 1
            scs_m.objs(index) = scicos_link();
            scs_m.objs(index).from = [start1,1,0];
            scs_m.objs(index).to = [start1 + 2,1,1];
            start1 = start1 + 2
        end
        
        // link z^-1 and triangle 1
        start1 = 2
        start2 = 2*length(bm) + 2
        for i = 1:length(bm)-1
            index = index + 1
            scs_m.objs(index) = scicos_link();
            scs_m.objs(index).from = [start1,1,0];
            scs_m.objs(index).to = [start2,1,1];
            scs_m.objs(index).xx= [20;220;-4]
            scs_m.objs(index).yy= [44;50 + 120*(i-1);20]
            start1 = start1 + 2
            start2 = start2 + 2
        end
        
        // link triangle1 and sum1
        start2 = 2*length(bm)
        start3 = 4*length(bm)
        for i = 1:length(bm)
            index = index + 1
            scs_m.objs(index) = scicos_link();
            scs_m.objs(index).from = [start2,1,0];
            if i == length(bm)
                start3 = start3 - 1
            end
            if (i==1) | (i==length(bm))
                scs_m.objs(index).to = [start3,2,1];
            else
                scs_m.objs(index).to = [start3,1,1];
            end
            start2 = start2 + 2
            start3 = start3 + 1
            if i == length(bm)
                scs_m.objs(index).xx= [44;510;10]   //doc
                scs_m.objs(index).yy= [20;50 + 120*(length(bm)-2);24]   // ngang
            end
        end
        
        // link sum1
        start3 = 4*length(bm)
        for i = 1:length(bm) - 2
            index = index + 1
            scs_m.objs(index) = scicos_link();
            scs_m.objs(index).from = [start3+1,1,0];
            if i == 1 
                scs_m.objs(index).to = [start3,1,1];
            else
                scs_m.objs(index).to = [start3,2,1];
            end
            start3 = start3 + 1
        end
        
        // link sum2
        start4 = 5*length(bm)-1
        for i = 1:length(an) - 1
            index = index + 1
            scs_m.objs(index) = scicos_link();
            scs_m.objs(index).from = [start4+1,1,0];
            if i == 1 
                scs_m.objs(index).to = [start4,1,1];
            else
                scs_m.objs(index).to = [start4,2,1];
            end
            start4 = start4 + 1
        end
        
        // link sum2 and triangle2
        start4 = 5*length(bm)
        start5 = 5*length(bm)-1 + length(an)
        for i = 1:length(an)
            index = index + 1
            scs_m.objs(index) = scicos_link();
            scs_m.objs(index).from = [start5,1,0];
            if i == length(an)
                start4 = start4 - 1
            end
            if (i==length(an)) 
                scs_m.objs(index).to = [start4,2,1];
            else
                scs_m.objs(index).to = [start4,1,1];
            end
            start4 = start4 + 1
            start5 = start5 + 2
            if i == length(an)
                scs_m.objs(index).xx= [-4;610;10]   //doc
                scs_m.objs(index).yy= [20;50 + 120*(length(an)-1);24]   // ngang
            end
        end
        
        // link triangles and z^-1
        start5 = 5*length(bm)-1 + length(an)
        start6 = 5*length(bm)-1 + 3*length(an)
        for i = 1:length(an)
            index = index + 1
            scs_m.objs(index) = scicos_link();
            scs_m.objs(index).from = [start6,1,0];
            scs_m.objs(index).to = [start5,1,1];
            scs_m.objs(index).xx= [20;870;44]
            scs_m.objs(index).yy= [44;50 + 120*(i-1);20]
            start5 = start5 + 2
            start6 = start6 + 2
        end
        
        // link z^-1 vertically
        start6 = 5*length(bm)-1 + 3*length(an)
        for i = 1:length(an)-1
            index = index + 1
            scs_m.objs(index) = scicos_link();
            scs_m.objs(index).from = [start6,1,0];
            scs_m.objs(index).to = [start6+2,1,1];
            start6 = start6 + 2
        end
        
        //link from x(n) to triangle
        index = index + 1
        scs_m.objs(index) = scicos_link();
        scs_m.objs(index).from = [1,1,0];
        scs_m.objs(index).to = [2*length(bm),1,1];
        
        // link from x(n) to z^-1
        index = index + 1
        scs_m.objs(index) = scicos_link();
        scs_m.objs(index).from = [1,1,0];
        scs_m.objs(index).to = [2,1,1];
        scs_m.objs(index).xx= [44;220;20]
        scs_m.objs(index).yy= [20;-70;-4]
        
        //link from sum 2 to z^-1
        index = index + 1
        scs_m.objs(index) = scicos_link();
        scs_m.objs(index).from = [5*length(bm)-1,1,0];
        scs_m.objs(index).to = [5*length(bm)-1 + 3*length(an),1,1];
        scs_m.objs(index).xx= [24;870;20]
        scs_m.objs(index).yy= [10;-70;-4]
        
        // link two sum
        index = index + 1
        scs_m.objs(index) = scicos_link();
        scs_m.objs(index).from = [4*length(bm),1,0];
        scs_m.objs(index).to = [5*length(bm)-1,2,1];
        
        // link to y(n)
        index = index + 1
        scs_m.objs(index) = scicos_link();
        scs_m.objs(index).from = [5*length(bm)-1,1,0];
        scs_m.objs(index).to = [5*length(bm) + 5*length(an)-1,1,1];
        xcos(scs_m)
    else
        index = 0
        // x(n)
        index = index + 1
        scs_m.objs(index) = CONST("define");
        scs_m.objs(index).graphics.exprs = "x(n)";
        scs_m.objs(index).graphics.orig = [50, 50]; 
        
        // sum 1
        index = index + 1
        scs_m.objs(index) = SUM_f("define");
        scs_m.objs(index).graphics.pin = [0;0];
        scs_m.objs(index).graphics.in_implicit = ["E", "E"];
        scs_m.objs(index).graphics.orig = [200, 60]; 
        scs_m.objs(index).graphics.in_style= ["ExplicitInputPort;align=center;verticalAlign=bottom;spacing=10.0;rotation=270";"ExplicitInputPort;align=left;verticalAlign=middle;spacing=10.0;rotation=0"]
        scs_m.objs(index).graphics.out_style= "ExplicitOutputPort;align=right;verticalAlign=middle;spacing=10.0;rotation=0"
        scs_m.objs(index).graphics.style= "SUM_f;flip=false"
        for i = 2:length(an) 
            index = index + 1
            scs_m.objs(index) = SUM_f("define");
            scs_m.objs(index).graphics.pin = [0;0];
            scs_m.objs(index).graphics.in_implicit = ["E", "E"];
            scs_m.objs(index).graphics.orig = [200, 60 - (i-1)*120]; 
            scs_m.objs(index).graphics.in_style= ["ExplicitInputPort;align=right;verticalAlign=middle;spacing=10.0;rotation=180";"ExplicitInputPort;align=center;verticalAlign=bottom;spacing=10.0;rotation=270"]
            scs_m.objs(index).graphics.out_style= "ExplicitOutputPort;align=center;verticalAlign=top;spacing=10.0;rotation=270"
            scs_m.objs(index).graphics.style= "SUM_f;rotation=90;flip=true;mirror=true"
        end
        
        // triangle 1
        for i = 2:length(an)+1
            index = index + 1
            scs_m.objs(index) = SQRT("define");
            scs_m.objs(index).graphics.style = "shape=triangle";
            scs_m.objs(index).graphics.orig = [350, 50 - (i-1)*120];
            scs_m.objs(index).graphics.in_style= "ExplicitInputPort;align=right;verticalAlign=middle;spacing=10.0;rotation=180"
            scs_m.objs(index).graphics.out_style= "ExplicitOutputPort;align=left;verticalAlign=middle;spacing=10.0;rotation=180"
            scs_m.objs(index).graphics.style= "shape=triangle;flip=false;mirror=true"
            
            index = index + 1
            scs_m.objs(index) = TEXT_f("define");
            scs_m.objs(index).graphics.orig = [355, 60 - (i-1)*120];
            scs_m.objs(index).graphics.exprs = [string(an(1,i-1));"2";"1"]
        end
        
        // z^-1
        lenMax = length(an)
        if length(bm) > lenMax
            lenMax = length(bm) - 1
        end
        
        for i = 1:lenMax
            index = index + 1
            scs_m.objs(index) = DELAY_f("define");
            scs_m.objs(index).graphics.orig = [500, -10 - (i-1)*120];
            scs_m.objs(index).graphics.style = "Z;rotation=90"
            scs_m.objs(index).graphics.in_style = "ExplicitInputPort;align=center;verticalAlign=top;spacing=10.0;rotation=90"
            scs_m.objs(index).graphics.out_style= "ExplicitOutputPort;align=center;verticalAlign=bottom;spacing=10.0;rotation=90"
            
            index = index + 1
            scs_m.objs(index) = TEXT_f("define");
            scs_m.objs(index).graphics.orig = [500, 0 - (i-1)*120];
            scs_m.objs(index).graphics.exprs = ["Z^-1";"2";"1"]
        end
        
        // triangle 2
        for i = 1:length(bm)
            index = index + 1
            scs_m.objs(index) = SQRT("define");
            scs_m.objs(index).graphics.style = "shape=triangle";
            scs_m.objs(index).graphics.orig = [650, 50 - (i-1)*120];
            
            index = index + 1
            scs_m.objs(index) = TEXT_f("define");
            scs_m.objs(index).graphics.orig = [645, 60 - (i-1)*120];
            scs_m.objs(index).graphics.exprs = [string(bm(1,i));"2";"1"]
        end
        
        // sum 2
        index = index + 1
        scs_m.objs(index) = SUM_f("define");
        scs_m.objs(index).graphics.pin = [0;0];
        scs_m.objs(index).graphics.in_implicit = ["E", "E"];
        scs_m.objs(index).graphics.orig = [820, 60]; 
        scs_m.objs(index).graphics.in_style= ["ExplicitInputPort;align=center;verticalAlign=bottom;spacing=10.0;rotation=270";"ExplicitInputPort;align=left;verticalAlign=middle;spacing=10.0;rotation=0"]
        scs_m.objs(index).graphics.out_style= "ExplicitOutputPort;align=right;verticalAlign=middle;spacing=10.0;rotation=0"
        scs_m.objs(index).graphics.style= "SUM_f;flip=false"
        for i = 2:length(bm) - 1
            index = index + 1
            scs_m.objs(index) = SUM_f("define");
            scs_m.objs(index).graphics.pin = [0;0];
            scs_m.objs(index).graphics.in_implicit = ["E", "E"];
            scs_m.objs(index).graphics.orig = [820, 60 - (i-1)*120]; 
            scs_m.objs(index).graphics.in_style= ["ExplicitInputPort;align=left;verticalAlign=middle;spacing=10.0;rotation=0";"ExplicitInputPort;align=center;verticalAlign=bottom;spacing=10.0;rotation=270"]
            scs_m.objs(index).graphics.out_style= "ExplicitOutputPort;align=center;verticalAlign=top;spacing=10.0;rotation=270"
            scs_m.objs(index).graphics.style= "SUM_f;rotation=90;mirror=true"
        end
        
        // y(n)
        index = index + 1
        scs_m.objs(index) = CONST_m("define");
        scs_m.objs(index).graphics.exprs = "y(n)";
        scs_m.objs(index).graphics.pin = 5;
        scs_m.objs(index).graphics.pout = [];
        scs_m.objs(index).graphics.out_implicit = [];
        scs_m.objs(index).graphics.in_implicit = "E";
        scs_m.objs(index).graphics.out_style = "";
        scs_m.objs(index).in_style = "ExplicitInputPort;align=left;verticalAlign=middle;spacing=10.0"
        scs_m.objs(index).graphics.orig = [950, 50];
        
        // link sum2
        start1 = 2
        for i = 1:length(an) - 1
            index = index + 1
            scs_m.objs(index) = scicos_link();
            scs_m.objs(index).from = [start1+1,1,0];
            if i == 1 
                scs_m.objs(index).to = [start1,1,1];
            else
                scs_m.objs(index).to = [start1,2,1];
            end
            start1 = start1 + 1
        end
        
        // link sum1 and triangle1
        start1 = 2 + 1
        start2 = 2 + length(an)
        for i = 1:length(an)
            index = index + 1
            scs_m.objs(index) = scicos_link();
            scs_m.objs(index).from = [start2,1,0];
            if i == length(an)
                start1 = start1 - 1
            end
            if (i==length(an)) 
                scs_m.objs(index).to = [start1,2,1];
            else
                scs_m.objs(index).to = [start1,1,1];
            end
            start1 = start1 + 1
            start2 = start2 + 2
            if i == length(an)
                scs_m.objs(index).xx= [-4;210;10]   //doc
                scs_m.objs(index).yy= [20;50 + 120*(length(an)-1);24]   // ngang
            end
        end
        
        // link z^-1 vertically
        start3 = 2 + 3*length(an)
        for i = 1:lenMax-1
            index = index + 1
            scs_m.objs(index) = scicos_link();
            scs_m.objs(index).from = [start3,1,0];
            scs_m.objs(index).to = [start3+2,1,1];
            start3 = start3 + 2
        end
        
        // link triangle2 and sum2
        start4 = 2 + 3*length(an) + 2*lenMax
        start5 = 2 + 3*length(an) + 2*lenMax + 2*length(bm)
        for i = 1:length(bm)
            index = index + 1
            scs_m.objs(index) = scicos_link();
            scs_m.objs(index).from = [start4,1,0];
            if i == length(bm)
                start5 = start5 - 1
            end
            if (i==1) | (i==length(bm))
                scs_m.objs(index).to = [start5,2,1];
            else
                scs_m.objs(index).to = [start5,1,1];
            end
            start4 = start4 + 2
            start5 = start5 + 1
            if i == length(bm)
                scs_m.objs(index).xx= [44;830;10]   //doc
                scs_m.objs(index).yy= [20;50 + 120*(length(bm)-2);24]   // ngang
            end
        end
        
        // link sum2
        start5 = 2 + 3*length(an) + 2*lenMax + 2*length(bm)
        for i = 1:length(bm) - 2
            index = index + 1
            scs_m.objs(index) = scicos_link();
            scs_m.objs(index).from = [start5+1,1,0];
            if i == 1 
                scs_m.objs(index).to = [start5,1,1];
            else
                scs_m.objs(index).to = [start5,2,1];
            end
            start5 = start5 + 1
        end
        
        // link x(n) and sum1
        index = index + 1
        scs_m.objs(index) = scicos_link();
        scs_m.objs(index).from = [1,1,0];
        scs_m.objs(index).to = [2,2,1];
        
        // link sum1 and triangle2\
        index = index + 1
        scs_m.objs(index) = scicos_link();
        scs_m.objs(index).from = [2,1,0];
        scs_m.objs(index).to = [2 + 3*length(an) + 2*lenMax,1,1];
        
        // link sum2 and y(n)
        index = index + 1
        scs_m.objs(index) = scicos_link();
        scs_m.objs(index).from = [2 + 3*length(an) + 2*lenMax + 2*length(bm),1,0];
        scs_m.objs(index).to = [1 + 3*length(an) + 2*lenMax + 3*length(bm),1,1];
        
        // link sum1 and z^-1
        index = index + 1
        scs_m.objs(index) = scicos_link();
        scs_m.objs(index).from = [2,1,0];
        scs_m.objs(index).to = [2 + 3*length(an),1,1];
        scs_m.objs(index).xx= [24;520;20]
        scs_m.objs(index).yy= [10;-70;-4]
        
        if lenMax == length(an)
            lenMin = length(bm) - 1
        else
            lenMin = length(an)
        end
        
        // link lenMin
        start2 = 2 + length(an)
        start3 = 2 + 3*length(an)
        start4 = 4 + 3*length(an) + 2*lenMax
        for i=1:lenMin
            index = index + 1
            scs_m.objs(index) = scicos_link();
            scs_m.objs(index).from = [start3,1,0];
            scs_m.objs(index).to = [start2,1,1];
            scs_m.objs(index).xx= [20;520;-4]
            scs_m.objs(index).yy= [10;50 + 120*(i-1);-4]
            
            index = index + 1
            scs_m.objs(index) = scicos_link();
            scs_m.objs(index).from = [start3,1,0];
            scs_m.objs(index).to = [start4,1,1];
            scs_m.objs(index).xx= [20;520;-4]
            scs_m.objs(index).yy= [10;50 + 120*(i-1);-4]
            
            start2 = start2 + 2
            start3 = start3 + 2
            start4 = start4 + 2
        end
        
        // link the remaining blocks
        startMid = 2+3*length(an)+ 2*lenMin
        if length(an) > length(bm)
            startRemain = 2 + length(an) + 2*lenMin
        else
            startRemain = 4 + 3*length(an) + 2*lenMax + 2*lenMin
        end
        for i=1:(lenMax - lenMin)
            index = index + 1
            scs_m.objs(index) = scicos_link();
            scs_m.objs(index).from = [startMid,1,0];
            scs_m.objs(index).to = [startRemain,1,1];
            scs_m.objs(index).xx= [20;520;-4]
            //scs_m.objs(index).yy= [10;50 + 120*(lenMin) + 120*(i-1);-4]
            scs_m.objs(index).yy= [44;50 + 120*(lenMin) + 120*(i-1);20]
            startMid = startMid + 2
            startRemain = startRemain + 2
        end
        xcos(scs_m)
    end
endfunction

// test
an = [1.5 2 ]
bm = [2 -3 5 7]
draw_system(an, bm, 0)
