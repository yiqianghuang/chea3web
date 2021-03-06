# R script to download selected samples
# Copy code and run on a local machine to initiate download

# Check for dependencies and install if missing
packages <- c("rhdf5")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
    print("Install required packages")
    source("https://bioconductor.org/biocLite.R")
    biocLite("rhdf5")
}
library("rhdf5")
library("tools")

destination_file = "human_matrix_download.h5"
extracted_expression_file = "Retina_expression_matrix.tsv"
url = "https://s3.amazonaws.com/mssm-seq-matrix/human_matrix.h5"

# Check if gene expression file was already downloaded and check integrity, if not in current directory download file form repository
if(!file.exists(destination_file)){
    print("Downloading compressed gene expression matrix.")
    download.file(url, destination_file, quiet = FALSE)
} else{
    print("Verifying file integrity...")
    checksum = md5sum(destination_file)
    
    if(destination_file == "human_matrix_download.h5"){
        # human checksum (checksum is for latest version of ARCHS4 data)
        correct_checksum = "f78da4a1855ff20da768eed1b73508be"
    } else{
        # mouse checksum (checksum is for latest version of ARCHS4 data)
        correct_checksum = "065abb20d2b9d2661e74328de8d23eb3"
    }
    
    if(checksum != correct_checksum){
        print("Existing file looks corrupted or is out of date. Downloading compressed gene expression matrix again.")
        download.file(url, destination_file, quiet = FALSE)
    } else{
        print("Latest ARCHS4 file already exists.")
    }
}

checksum = md5sum(destination_file)
if(destination_file == "human_matrix_download.h5"){
    # human checksum (checksum is for latest version of ARCHS4 data)
    correct_checksum = "f78da4a1855ff20da768eed1b73508be"
} else{
    # mouse checksum (checksum is for latest version of ARCHS4 data)
    correct_checksum = "065abb20d2b9d2661e74328de8d23eb3"
}

if(checksum != correct_checksum){
    print("File download ran into problems. Please try to download again. The files are also available for manual download at http://amp.pharm.mssm.edu/archs4/download.html.")
} else{
    # Selected samples to be extracted
    samp = c("GSM1099816","GSM1099813","GSM995549","GSM898971","GSM995551","GSM1099814","GSM1099815","GSM995550","GSM2203767","GSM2203765","GSM2203766","GSM1657726","GSM1657727","GSM2203764","GSM2203768","GSM1657729","GSM1657731","GSM1657728","GSM2203763","GSM1657730","GSM2323826","GSM2323825","GSM2319597","GSM2319600","GSM2319603","GSM2319605","GSM2319598","GSM2319608","GSM2319604","GSM2319609","GSM2319607",
"GSM2319602","GSM2319606","GSM2319601","GSM2319599","GSM2467191","GSM2467179","GSM2467190","GSM2467180","GSM2475309","GSM2475287","GSM2475311","GSM2475307","GSM2475305","GSM2475291","GSM2475299","GSM2475315","GSM2475293","GSM2475289","GSM2475301","GSM2475297","GSM2475295","GSM2475285","GSM2475313","GSM2475303","GSM2644289","GSM2644290","GSM2644291","GSM2644292","GSM2644297","GSM2644298",
"GSM2644299","GSM2644300","GSM2644305","GSM2644306","GSM2644307","GSM2644308","GSM2782496","GSM2782497","GSM2782498","GSM2782499","GSM2782500","GSM2782501","GSM2808439","GSM2808440","GSM2808441","GSM2808442","GSM2808443","GSM2808444","GSM2808445","GSM2808446","GSM2808447","GSM2808448","GSM2808449","GSM2808450","GSM2808451","GSM2808452","GSM2808453","GSM2808454","GSM2808455","GSM2808456",
"GSM2808457","GSM2808458","GSM2808459","GSM2808460","GSM2808461","GSM2808462","GSM2808463","GSM2747191","GSM2747192","GSM2747193","GSM2747194","GSM2747195","GSM2747196","GSM2747197","GSM2747198","GSM2747199","GSM2747200","GSM2747201","GSM2747202","GSM2371252","GSM2638036","GSM2638038","GSM2638039","GSM2638041","GSM2638043","GSM2638045","GSM2638047","GSM2638049","GSM2638051","GSM2638053",
"GSM2638055","GSM2638057","GSM2638059","GSM2638061","GSM2638063","GSM2638065","GSM2599126","GSM2599127","GSM2599128","GSM2599129","GSM2599130","GSM2599131","GSM2599132","GSM2599133","GSM2599134","GSM2599135","GSM2599136","GSM2599137","GSM2599138","GSM2599139","GSM2599140","GSM2599141","GSM2599142","GSM2599143","GSM2599144","GSM2599145","GSM2599146","GSM2599147","GSM2599148","GSM2599149",
"GSM2599150","GSM2599151","GSM2599152","GSM2599153","GSM2599154","GSM2599155","GSM2599156","GSM2599157","GSM2599158","GSM2599159","GSM2599160","GSM2599161","GSM2599162","GSM2599163","GSM2599164","GSM2599165","GSM2599166","GSM2599167","GSM2599168","GSM2599169","GSM2599170","GSM2599171","GSM2599172","GSM2599173","GSM2599174","GSM2599175","GSM2599176","GSM2599177","GSM2599178","GSM2599179",
"GSM2599180","GSM2599181","GSM2599182","GSM2599183","GSM2599184","GSM2599185","GSM2599186","GSM2599187","GSM2599188","GSM2599189","GSM2599190","GSM2599191","GSM2599192","GSM2599193","GSM2599194","GSM2599195","GSM2599196","GSM2599197","GSM2599198","GSM2599199","GSM2599200","GSM2599201","GSM2599202","GSM2599203","GSM2599204","GSM2599205","GSM2599206","GSM2599207","GSM2599208","GSM2599209",
"GSM2599210","GSM2599211","GSM2599212","GSM2599213","GSM2599214","GSM2599215","GSM2599216","GSM2599217","GSM2599218","GSM2599219","GSM2599220","GSM2599221","GSM2599222","GSM2599223","GSM2599224","GSM2599225","GSM2599226","GSM2599227","GSM2599228","GSM2599229","GSM2599230","GSM2599231","GSM2599232","GSM2599233","GSM2599234","GSM2599235","GSM2599236","GSM2599237","GSM2599239","GSM2599240",
"GSM2599241","GSM2599242","GSM2599243","GSM2599244","GSM2599245","GSM2599246","GSM2599247","GSM2599248","GSM2599249","GSM2599250","GSM2599251","GSM2599252","GSM2599253","GSM2599254","GSM2599255","GSM2599256","GSM2599257","GSM2599258","GSM2599259","GSM2599260","GSM2599261","GSM2599262","GSM2599263","GSM2599264","GSM2599265","GSM2599266","GSM2599267","GSM2599268","GSM2599269","GSM2599270",
"GSM2599271","GSM2599272","GSM2599273","GSM2599274","GSM2599275","GSM2599276","GSM2599277","GSM2599278","GSM2599279","GSM2599280","GSM2599281","GSM2599282","GSM2599283","GSM2599284","GSM2599285","GSM2599286","GSM2599287","GSM2599288","GSM2599289","GSM2599290","GSM2599291","GSM2599292","GSM2599293","GSM2599294","GSM2599295","GSM2599296","GSM2599297","GSM2599298","GSM2599299","GSM2599300",
"GSM2599301","GSM2599302","GSM2599303","GSM2599304","GSM2599305","GSM2599306","GSM2599307","GSM2599308","GSM2599309","GSM2599310","GSM2599311","GSM2599312","GSM2599313","GSM2599314","GSM2599315","GSM2599316","GSM2599317","GSM2599318","GSM2599319","GSM2599320","GSM2599321","GSM2599322","GSM2599323","GSM2599324","GSM2599325","GSM2599326","GSM2599327","GSM2599328","GSM2599329","GSM2599330",
"GSM2599331","GSM2599332","GSM2599333","GSM2599334","GSM2599335","GSM2599336","GSM2599337","GSM2599338","GSM2599339","GSM2599340","GSM2599341","GSM2599342","GSM2599343","GSM2599344","GSM2599345","GSM2599346","GSM2599347","GSM2599348","GSM2599349","GSM2599350","GSM2599351","GSM2599352","GSM2599353","GSM2599354","GSM2599355","GSM2599356","GSM2599357","GSM2599358","GSM2599359","GSM2599360",
"GSM2599361","GSM2599362","GSM2599363","GSM2599364","GSM2599365","GSM2599366","GSM2599367","GSM2599368","GSM2599369","GSM2599370","GSM2599371","GSM2599372","GSM2599373","GSM2599374","GSM2599375","GSM2599376","GSM2599377","GSM2599378","GSM2599379","GSM2599380","GSM2599381","GSM2599382","GSM2599383","GSM2599384","GSM2599385","GSM2599386","GSM2599387","GSM2599388","GSM2599389","GSM2599390",
"GSM2599391","GSM2599392","GSM2599393","GSM2599394","GSM2599395","GSM2599396","GSM2599397","GSM2599398","GSM2599399","GSM2599400","GSM2599401","GSM2599402","GSM2599403","GSM2599405","GSM2599406","GSM2599408","GSM2599409","GSM2599410","GSM2599411","GSM2599412","GSM2599414","GSM2599415","GSM2599416","GSM2599418","GSM2599421","GSM2599422","GSM2599424","GSM2599425","GSM2599426","GSM2599427",
"GSM2599428","GSM2599429","GSM2599430","GSM2599431","GSM2599432","GSM2599433","GSM2599434","GSM2599435","GSM2599436","GSM2599437","GSM2599438","GSM2599439","GSM2599440","GSM2599441","GSM2599443","GSM2599444","GSM2599445","GSM2599446","GSM2599447","GSM2599449","GSM2599450","GSM2599451","GSM2599452","GSM2599453","GSM2599454","GSM2599455","GSM2599456","GSM2599457","GSM2599458","GSM2599459",
"GSM2599460","GSM2599461","GSM2599462","GSM2599463","GSM2599464","GSM2599465","GSM2599466","GSM2599467","GSM2599468","GSM2599469","GSM2599470","GSM2599471","GSM2599472","GSM2599473","GSM2599474","GSM2599475","GSM2599476","GSM2599477","GSM2599478","GSM2599479","GSM2599480","GSM2599481","GSM2599482","GSM2599483","GSM2599484","GSM2599485","GSM2599486","GSM2599487","GSM2599488","GSM2599489",
"GSM2599490","GSM2599491","GSM2599492","GSM2599493","GSM2599494","GSM2599495","GSM2599496","GSM2599497","GSM2599499","GSM2599500","GSM2599501","GSM2599502","GSM2599503","GSM2599504","GSM2599505","GSM2599506","GSM2599507","GSM2599508","GSM2599509","GSM2599510","GSM2599511","GSM2599512","GSM2599513","GSM2599514","GSM2599515","GSM2599516","GSM2599517","GSM2599518","GSM2599519","GSM2599520",
"GSM2599521","GSM2599522","GSM2599523","GSM2599524","GSM2599525","GSM2599526","GSM2599527","GSM2599529","GSM2599530","GSM2599531","GSM2599532","GSM2599533","GSM2599534","GSM2599535","GSM2599536","GSM2599537","GSM2599538","GSM2599539","GSM2599540","GSM2599541","GSM2599542","GSM2599543","GSM2599544","GSM2599545","GSM2599546","GSM2599547","GSM2599548","GSM2599549","GSM2599550","GSM2599551",
"GSM2599552","GSM2599553","GSM2599554","GSM2599555","GSM2599556","GSM2599557","GSM2599558","GSM2599559","GSM2599560","GSM2599561","GSM2599562","GSM2599563","GSM2599564","GSM2599565","GSM2599566","GSM2599567","GSM2599568","GSM2599569","GSM2599570","GSM2599571","GSM2599572","GSM2599573","GSM2599574","GSM2599575","GSM2599576","GSM2599577","GSM2599578","GSM2599579","GSM2599580","GSM2599581",
"GSM2599582","GSM2599583","GSM2599584","GSM2599585","GSM2599586","GSM2599587","GSM2599588","GSM2599589","GSM2599590","GSM2599591","GSM2599592","GSM2599593","GSM2599594","GSM2599595","GSM2599596","GSM2599597","GSM2599598","GSM2599599","GSM2599600","GSM2599601","GSM2599602","GSM2599603","GSM2599604","GSM2599605","GSM2599606","GSM2599607","GSM2599608","GSM2599609","GSM2599610","GSM2599611",
"GSM2599612","GSM2599613","GSM2599614","GSM2599615","GSM2599616","GSM2599617","GSM2599618","GSM2599619","GSM2599620","GSM2599621","GSM2599622","GSM2599623","GSM2599624","GSM2599625","GSM2599626","GSM2599627","GSM2599628","GSM2599629","GSM2599630","GSM2599631","GSM2599632","GSM2599633","GSM2599634","GSM2599635","GSM2599636","GSM2599637","GSM2599638","GSM2599639","GSM2599640","GSM2599641",
"GSM2599642","GSM2599643","GSM2599644","GSM2599645","GSM2599646","GSM2599647","GSM2599648","GSM2599649","GSM2599650","GSM2599651","GSM2599652","GSM2599653","GSM2599654","GSM2599655","GSM2599656","GSM2599657","GSM2599658","GSM2599659","GSM2599660","GSM2599661","GSM2599662","GSM2599663","GSM2599664","GSM2599665","GSM2599666","GSM2599667","GSM2599668","GSM2599669","GSM2599670","GSM2599671",
"GSM2637927","GSM2637928","GSM2637929","GSM2637930","GSM2637931","GSM2637932","")

    # Retrieve information from compressed data
    samples = h5read(destination_file, "meta/Sample_geo_accession")
    tissue = h5read(destination_file, "meta/Sample_source_name_ch1")
    genes = h5read(destination_file, "meta/genes")

    # Identify columns to be extracted
    sample_locations = which(samples %in% samp)

    # extract gene expression from compressed data
    expression = h5read(destination_file, "data/expression", index=list(1:length(genes), sample_locations))
    H5close()
    rownames(expression) = genes
    colnames(expression) = samples[sample_locations]

    # Print file
    write.table(expression, file=extracted_expression_file, sep="\t", quote=FALSE)
    print(paste0("Expression file was created at ", getwd(), "/", extracted_expression_file))
}
