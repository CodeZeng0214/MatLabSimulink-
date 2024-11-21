function mySfunc(block)

setup(block);
  
function setup(block)

  % Register the number of ports.
  block.NumInputPorts  = 3;
  block.NumOutputPorts = 2;
  
  % 设置端口属性为动态
  block.SetPreCompInpPortInfoToDynamic;
  block.SetPreCompOutPortInfoToDynamic;

  %% Override the input port properties.
  block.InputPort(1).DatatypeID  = 0;  % double
  block.InputPort(1).Complexity  = 'Real';
  block.InputPort(1).SamplingMode = 'Sample';

  block.InputPort(2).DatatypeID  = 0;  % double
  block.InputPort(2).Complexity  = 'Real';
  block.InputPort(2).SamplingMode = 'Sample';

  block.InputPort(3).DatatypeID  = 0;  % double
  block.InputPort(3).Complexity  = 'Real';
  block.InputPort(3).SamplingMode = 'Sample';

  

  %% Override the output port properties.

  block.OutputPort(1).DatatypeID  = 0; % double
  block.OutputPort(1).Complexity  = 'Real';
  block.OutputPort(1).SamplingMode = 'Sample';
  %block.OutputPort(1).FrameData = false; % No frame-based processing
  
  % Override the output port properties.
  block.OutputPort(2).DatatypeID  = 0; % double
  block.OutputPort(2).Complexity  = 'Real';
  block.OutputPort(2).SamplingMode = 'Sample';

  %block.OutputPort(2).FrameData = false; % No frame-based processing

  % % Register the parameters.
  % block.NumDialogPrms     = 3;
  % block.DialogPrmsTunable = {'Tunable','Nontunable','SimOnlyTunable'};
  
  %% Set up the continuous states.
  block.NumContStates = 2;

  %% Register the sample times.
  %  [0 offset]            : Continuous sample time
  %  [positive_num offset] : Discrete sample time
  %
  %  [-1, 0]               : Inherited sample time
  %  [-2, 0]               : Variable sample time
  block.SampleTimes = [0 0];

  
  %% Register methods
  block.RegBlockMethod('InitializeConditions', @InitializeConditions);
  block.RegBlockMethod('Outputs',              @Outputs);
  block.RegBlockMethod('Derivatives',          @Derivatives);
end

  
%% 详细定义的函数

  function InitializeConditions(block)
  % Initialize states
  block.ContStates.Data = [0; 0]; % Initial conditions for x1 and x2
  end
  function Outputs(block)
  % Output the current state values x1 and x2
  x = block.ContStates.Data;
  block.OutputPort(1).Data = x(1); % Output x1
  block.OutputPort(2).Data = x(2); % Output x2
  end

  function Derivatives(block)
  % State equations from the image
  
  % 获取参数值
  m = 1; % Mass
  k = 1; % Stiffness
  k1 = 1; % Control parameter k1
  k2 = 1; % Control parameter k2

  % 获取当前状态
  x1 = block.ContStates.Data(1);
  x2 = block.ContStates.Data(2);

  % 获取输入 (x1d, dx1d, ddx1d)
  x1d = block.InputPort(1).Data;
  dx1d = block.InputPort(2).Data;
  ddx1d = block.InputPort(3).Data;

  % 误差计算
  e1 = x1d - x1;
  e2 = dx1d + k1 * e1 - x2;
  
  % 控制输入 u 的计算
  u = m * ddx1d + m * k1 * (dx1d - x2) + k * x1^3 + m * k2 * e2;

  % 计算状态导数
  dx1 = x2;
  dx2 = - (k/m) * x1^3 + (1/m) * u;

  % 更新导数
  block.Derivatives.Data = [dx1; dx2];
  end

end