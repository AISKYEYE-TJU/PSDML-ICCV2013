% ========================================================================
% PPDML PSDML SSDML, Version 1.0
% Copyright(c) 2013 Pengfei Zhu Faqiang Wang
% All Rights Reserved.
%
% ----------------------------------------------------------------------
% Permission to use, copy, or modify this software and its documentation
% for educational and research purposes only and without fee is here
% granted, provided that this copyright notice and the original authors'
% names appear on all copies and supporting documentation. This program
% shall not be used, rewritten, or adapted as the basis of any commercial
% software or hardware product without first obtaining permission of the
% authors. The authors make no representations about the suitability of
% this software for any purpose. It is provided "as is" without express
% or implied warranty.
%----------------------------------------------------------------------
%
%
% Please refer to the following paper:
[1] P. Zhu, L. Zhang, W. Zuo, et al. From Point to Set: Extend the Learning of 
Distance Metrics. ICCV2013 
[2] F. Wang, W. Zuo, L. Zhang, et al. A Kernel Classification Framework for 
Metric Learning. arXiv:1309.5823, http://arxiv.org/abs/1309.5823. 

% Contact: zhupengfeifly@gmail.com 
%----------------------------------------------------------------------
%usage:
%firstly add path
currentFolder = pwd; addpath(genpath(currentFolder))
%Point to Point Distance Metric Learning (PPDML) run
demo_PPDML('Sonar',1,3)
%Point to Set Distance Metric Learning (PSDML) run
demo_PSDML('yaleB_PSDML',1,50)
demo_PSDML('yaleB_PSDML',2,100)
demo_PSDML('yaleB_PSDML',2,150)
%Set to Set Distance Metric Learning (SSDML) Please refer to
demo_SSDML(50)
%If you find any bug, please contact me. 





