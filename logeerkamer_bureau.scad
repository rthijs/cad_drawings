//kamer
kamer = [1920,1580,2460];
muur_dikte = 200;
plint_h = 100;
plint_d = 10;

// allerlei
mdf_dikte = 18;
ooghoogte = 1270;
armafstand = 450;

// toetsenbord + muis
toetsenbord = [460,160,30];
muis = [70,100,35];

// schermen
scherm_p = [830,40,429];

// synthesizer
synth = [367,1024,119];
synth_marge_kabels = 130;
synth_h = 650;

// midi controller
midi = [940,270,90];

// werkblad
werkblad = [1920,700,40];
werkhoogte = 730;

//schabben hoog
plint_plafond_hoogte = 140;
stripboek_hoogte = 315;
stripboek_hoogte_marge = 20;
stripboek_diepte = 225;
stripboek_diepte_marge = 20;
boek_hoogte = 250;
boek_diepte = 170;
boek_hoogte_marge = 20;
boek_diepte_marge = 20;
cd_hoogte = 125;
cd_diepte = 142;
cd_marge_h = 15;
cd_marge_d = 5;




// de kamer zelf
color([.2,.2,.2,.5]) {
    translate([-muur_dikte,0,0]){
        cube([muur_dikte,kamer.y,kamer.z]);
    }
    translate([-muur_dikte,-muur_dikte,0]){
        cube([kamer.x+muur_dikte,muur_dikte,kamer.z]);
    }
    translate([-muur_dikte,-muur_dikte,-muur_dikte]){
        cube([kamer.x+muur_dikte,kamer.y+muur_dikte,muur_dikte]);
    }
    translate([-0,-0,-0]){
        cube([kamer.x,plint_d,plint_h]);
    }
    translate([-0,-0,-0]){
        cube([plint_d,kamer.y,plint_h]);
    }
}

// primair scherm
{
    translate([werkblad.x/2 - scherm_p.x/2, werkblad.y - scherm_p.y - armafstand, ooghoogte -scherm_p.z]){
        # cube(scherm_p);
    }
}

// synth
/*
{ 
    translate([synth_marge_kabels,kamer.y - synth.y, synth_h]){
        # cube(synth);
    }
}
*/

// toetsenbord + muis
{
    translate([0,0,werkhoogte]){
       translate([  werkblad.x/2-toetsenbord.x/2,
                    werkblad.y-toetsenbord.y-300,
                    0]){
            # cube(toetsenbord);
            translate([-150,40,0]){
                # cube(muis);
            }
        }
    }
}

// midi
/*
{
    translate([ werkblad.x/2-midi.x/2,0,werkhoogte]){
        # cube(midi);
    }
}
*/




//werkblad
{
    translate([0,0,werkhoogte-werkblad.z]){
        cube([werkblad.x, werkblad.y, werkblad.z]);
    }
}


// cd rek
translate([0,kamer.y - 1100,kamer.z-1000]) {
    rotate([-45,0,0]){
        teken_cd_rek();
    }
}

//wandkasten
translate([0,0,kamer.z]){
    teken_wand_kast();
}



module teken_cd_rek() {
    n_hoeken = 3; // aantal hoekvormige modules in het rek
    cdvak = [cd_diepte + cd_marge_d,cd_hoogte + cd_marge_h,cd_hoogte + cd_marge_h];
    
    // kast bestaat uit hoekvormige modules en een afsluitend hoekje
    for(i=[0:n_hoeken-1]){
        teken_hoek_module(i);
    }
    //afsluitend hoekje
    teken_afsluitend_hoekje(n_hoeken);
    
    /*
    * lijn trekken om de maximale breedte te zien
    */
    //teken_max_breedte(1000);
    
    /*
    * cd blokken tekenen om te zien of alles past
    */
    //teken_cds();
    
    /*
    * helperfunties en -modules
    */
    module teken_hoek_module(n) {
        l4 = 4*cdvak.y + 2*mdf_dikte;   // lengte plank van 4 eenheden
        l5 = 5*cdvak.y + 2*mdf_dikte;   // lengte plank van 5 eenheden
        l1 = cdvak.y;                   // inliggend plankje van 1 eenheid
        
        translate([0,n*(mdf_dikte+cdvak.y),n*(mdf_dikte+cdvak.z)]) {
            {
                if (n==0) {
                    cube([cdvak.x,l4,mdf_dikte]);
                } else {
                    translate([0,-cdvak.y,0]) {
                        cube([cdvak.x,l5,mdf_dikte]);
                    }
                }
            }
            
            translate([0,0,mdf_dikte]) {
                cube([cdvak.x,mdf_dikte,l4]);
            }
            
            translate([0,mdf_dikte,l4]) {
                cube([cdvak.x,l1,mdf_dikte]);
            }
            
            translate([0,l4-mdf_dikte,mdf_dikte]) {
                cube([cdvak.x,mdf_dikte,l1]);
            }
        }
        
    }
    
    module teken_afsluitend_hoekje(n_hoeken) {

        translate([ 0,
                    (n_hoeken-1) * cdvak.y + n_hoeken * mdf_dikte,
                    n_hoeken * mdf_dikte + n_hoeken * cdvak.z]) 
        {
            l = 4*cdvak.y + mdf_dikte;
            cube([cdvak.x,l,mdf_dikte]);
        }
        
        translate([ 0,
                    n_hoeken * cdvak.y + n_hoeken * mdf_dikte,
                    (n_hoeken+1) * mdf_dikte + n_hoeken * cdvak.z]) 
        {
            l = 3*cdvak.y + mdf_dikte;
            cube([cdvak.x,mdf_dikte,l]);
        }
        
        translate([ 0,
                    n_hoeken * cdvak.y + (n_hoeken+1) * mdf_dikte,
                    (n_hoeken+1) * (mdf_dikte + cdvak.z)]) 
        {
            l = cdvak.y + mdf_dikte;
            cube([cdvak.x,l,mdf_dikte]);
        }
        
        translate([ 0,
                    (n_hoeken+1) * (cdvak.y + mdf_dikte),
                    (n_hoeken+1) * mdf_dikte + n_hoeken * cdvak.z]) 
        {
            l = cdvak.y;
            cube([cdvak.x,mdf_dikte,l]);
        }

    }
    
    
    module teken_max_breedte(max_l) {
        rotate([45,0,0]){
            translate([-5,0,0]){
                color([0,1,1,1]) cube([10,max_l,10]);
            }
        }
    }
    
    module teken_cds() {
        n_rijen = 3; // aantal "vakken" dat het cd rek heeft
        cd_kleur = [.91,.48,.81,.6];
        
        function offset_y(kolom) = mdf_dikte + kolom * (cdvak.y+mdf_dikte);
        function offset_z(rij) = mdf_dikte + rij * (cdvak.z+mdf_dikte);

        // rijen opvullen
        for(j=[0:n_rijen - 1]) {
            for(i=[0:n_rijen]) {
                translate([ 0,
                            offset_y(j) + i*cdvak.y,
                            offset_z(j) ])
                {
                    color(cd_kleur) cube(cdvak);
                }
            }
        }
        
        // kolommen opvullen
        for(j=[0:n_rijen-1]) {
            translate([0,0,offset_z(j)]) {
                for(i=[1:n_rijen]){
                    translate([0,offset_y(j),mdf_dikte+i*cdvak.z]) {
                        color(cd_kleur) cube(cdvak);
                    }
                }
            }
        }
        
        // laatste vakje opvullen
        translate([
            0,
            mdf_dikte + n_rijen * (mdf_dikte + cdvak.y),
            mdf_dikte + n_rijen * (mdf_dikte + cdvak.z)]) 
        { 
                    color(cd_kleur) cube(cdvak); 
        }
    }
}

module teken_wand_kast() {
    //teken_boeken();
    //van boven naar beneden: plint - strips - boeken - boeken - boeken
    teken_plint();
    teken_strip_module(1);
    
    
    module teken_plint(){
        x = 0;
        y = stripboek_diepte + stripboek_diepte_marge - mdf_dikte;
        z = -plint_plafond_hoogte;
        
        //voorkant
        translate([x,y+mdf_dikte,z]){
            cube([kamer.x, mdf_dikte,plint_plafond_hoogte]);
        }
        
        //zijkant
        translate([kamer.x-mdf_dikte,0,z]){
            cube([mdf_dikte, y+mdf_dikte,plint_plafond_hoogte]);
        }
    }
    
    module teken_strip_module(vakken) {
        h = stripboek_hoogte + stripboek_hoogte_marge;
        b = kamer.x;
        d = stripboek_diepte + stripboek_diepte_marge;
        
        //achterwand
        translate([mdf_dikte,0,-plint_plafond_hoogte-h-mdf_dikte]){
            cube([b-2*mdf_dikte,mdf_dikte,h]);
        }
        
        //onderste plank
        translate([0,0,-plint_plafond_hoogte-h-2*mdf_dikte]){
            cube([b,d+mdf_dikte,mdf_dikte]);
        }
        
        //bovenste plank
        translate([0,0,-plint_plafond_hoogte-mdf_dikte]){
            cube([b,d+mdf_dikte,mdf_dikte]);
        }
        
        //zijkanten
        translate([0,0,-plint_plafond_hoogte-h-mdf_dikte]){
            cube([mdf_dikte,d+mdf_dikte,h]);
        }
        translate([kamer.x-mdf_dikte,0,-plint_plafond_hoogte-h-mdf_dikte]){
            cube([mdf_dikte,d+mdf_dikte,h]);
        }
    }
    
    module teken_boeken(){
        h = stripboek_hoogte + stripboek_hoogte_marge;
        b = kamer.x;
        d = stripboek_diepte + stripboek_diepte_marge;
        translate([0,mdf_dikte,-plint_plafond_hoogte-h-mdf_dikte]){
            #cube([b,d,h]);
        }
    }
}




