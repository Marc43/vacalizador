function etiquetaObjectes(IM, bbox)
    tamanyBloc = 25;
    [n, m, ~] = size(IM);

    [blocs, numBlocs, esObjecte] = imatgeBlocs(IM, bbox, tamanyBloc);
        
    %donats els blocs i si es objecte, dibuixem punts per tal de verificar
    %que shan determinat els blocs pertanyents al objecte correctament
    
    imshow(IM);
    hold on;

     for i=1:size(esObjecte)
         plot(esObjecte(i, 1), esObjecte(i, 2), 'ob')
         hold on 
     end

    histos = extractFeatures(blocs, numBlocs);
%     
%     for i=1:numBlocs
%         
%     end

end