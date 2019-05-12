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
plint_plafond_hoogte = 10;
stripboek_hoogte = 294;
stripboek_hoogte_marge = 20;
stripboek_diepte = 223;
stripboek_diepte_marge = 20;
boek_hoogte = 250;
boek_diepte = 180;
cd_hoogte = 125;
cd_diepte = 142;
cd_marge_h = 30;
cd_marge_d = 10;




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
/*
translate([0,200,200]){
    max_breedte = 1000;
    rotate([45,0,0]){
        translate([-5,0,0]){
            color([0,1,1,1]) cube([10,max_breedte,10]);
        }
    }
    
    eenheid = cd_hoogte + cd_marge_h;
    eenheidsvak = [cd_diepte + cd_marge_d,eenheid,eenheid];
    
    kleur_l3_hor = [1,0,0,.5];
    kleur_l3_ver = [1,0,1,.5];
    kleur_l1_ver = [1,1,0,.5];
    kleur_3 = [0,1,1,1];
    
    // platen van 3 eenheden: rijen 0,1,2,3,6 (volle lengte, de kolommen zijn inliggende maten)
    color(kleur_l3_hor) { 
        for(i = [0,1,2,3]) {
            translate([0, i * eenheidsvak.y, eenheidsvak.y * i]){
                cube([eenheid, eenheid * 3, mdf_dikte]);
            }
        }
        translate([0, eenheidsvak.y * 3, eenheidsvak.y * 6]){
            cube([eenheidsvak.x, eenheidsvak.y * 3, mdf_dikte]);
        }
    }
    
    // platen van 3 vertikaal: kolommen 0,4,6 (lengte is 3 eenheden - 2*dikte mdf)
    color(kleur_l3_ver) {
        
        lengte_v3 = eenheid*3 - mdf_dikte;        

        translate(trans_cd(0,0)){ cd_plank(lengte_v3); }
        translate(trans_cd(3,0)){ cd_plank(lengte_v3); }
    }

        
    // plaatjes van 1, grootte = cd hoogte + marge = cd_vak
    color(kleur_l1_ver) {    
        for(i = [0:2]) {
            translate([0,i*eenheidsvak.y,i*eenheidsvak.y]){    
                translate([0,eenheidsvak.y*3-mdf_dikte,mdf_dikte]){
                    cube([eenheidsvak.x, mdf_dikte, eenheidsvak.y - mdf_dikte]);
                }
            }
        }
    }
    
    teken_cds(0,0,1,0);
    teken_cds(eenheid + mdf_dikte,0,0);
    # teken_cds(2*eenheid + mdf_dikte,0,0);
    
}
*/
teken_cd_rek();


module plank_h3(r,k) {
    x = cd_diepte + cd_marge_d;
    y = 3*(cd_hoogte + cd_marge) + 3*mdf_dikte;
    z = mdf_dikte;
    offset_x = 0;
    offset_y = 0;
}

module cd_plank(lengte) { 
    eenheid = cd_hoogte + cd_marge_h;
    cube([eenheid,mdf_dikte,lengte]); 
}

function trans_cd(r,k) = 
    let (eenheid = cd_hoogte + cd_marge_h)
    let (ofset_y = r * (eenheid+mdf_dikte))
    [r*(eenheid+mdf_dikte),ofset_y,r*eenheid+mdf_dikte];

module teken_cds(y,z,r,l) {
    unit_box = [cd_diepte + cd_marge_d,cd_hoogte + cd_marge_h,cd_hoogte + cd_marge_h];
    cd_box = [cd_diepte,cd_hoogte+cd_marge_h,cd_hoogte];
    unit_color = [181/255, 175/255, 247/255,.2];
    cd_color = [196/255, 93/255, 252/255, 1];
    translate([0,y+r*(cd_hoogte + cd_marge_h),z+mdf_dikte]){
        rotate([r*90,0,0]) {
            //color(unit_color) cube(unit_box);
            color(cd_color) cube(cd_box);
        }
    }
}


module teken_cd_rek() {
    n_hoeken = 3; // aantal hoekvormige modules in het rek
    cdvak = [cd_diepte + cd_marge_d,cd_hoogte + cd_marge_h,cd_hoogte + cd_marge_h];
    
    // kast bestaat uit hoekvormige modules en een afsluitend hoekje
    for(i=[0:n_hoeken-1]){
        teken_hoek_module(i);
    }
    //afsluitend hoekje
    
    

    
    
    /*
    * lijn trekken om de maximale breedte te zien
    */
    teken_max_breedte(1000);
    
    /*
    * cd blokken tekenen om te zien of alles past
    */
    teken_cds();
    
    /*
    * helperfunties en -modules
    */
    module teken_hoek_module(n) {
        l4 = 4*cdvak.y + 2*mdf_dikte;   // lengte plank van 4 eenheden
        l5 = 5*cdvak.y + 2*mdf_dikte;   // lengte plank van 4 eenheden
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
 




