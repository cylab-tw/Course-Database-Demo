var ATMApp = angular.module("ATMrApp", []);
ATMApp.controller("ATMCtrl", function ($scope, ATMService) {
  /**variables initialize*/
  $scope.StartSDate = "";
  $scope.EndSDate = "";
  $scope.QueryKeys = "";
  $scope.LogList = [];
  $scope.LogListSize = "";
  $scope.selectedLog = {};

  $scope.Query = function () {
    $scope.Clear();
    for (var key in $scope.selectedLog) {
      if ($scope.selectedLog[key].trim() == "")
        delete $scope.selectedLog[key];
    }
    var QueryKeys = $scope.selectedLog;
    ATMService.Load_Trans(QueryKeys).then(function (res) {
      if (res.recordset == "") {
        $scope.LogListSize = 0;
        $scope.LogList = [];
      } else {
        $scope.LogList = res.data;
        $scope.LogListSize = $scope.LogList.length;
      }
    });
  };

  $scope.Insert = function () {
    ATMService.Add_Trans($scope.selectedLog).then(function (res) {
      if (res.data == "success") {
        alert("新增成功");
        $scope.Query();
      } else {
        alert("新增失敗: " + res);
      }
    });
  };

  $scope.Update = function () {
    ATMService.Update_Trans($scope.selectedLog).then(function (res) {
      if (res.data == "success") {
        alert("修改成功");
        $scope.Query();
      } else {
        alert("修改失敗: " + res);
      }
    });
  };

  $scope.Delete = function () {
    ATMService.Delete_Trans($scope.selectedLog).then(function (res) {
      if (res.data == "success") {        
        alert("刪除成功");
        $scope.Query();
      } else {
        alert("刪除失敗: " + res);
      }
    });
  };

  $scope.Clear = function () {
    $scope.LogList = "";
    $scope.selectedLog = "";
    $scope.LogListSize = 0;
  }

  $scope.getLog = function (item, target) {
    console.log(item);
    $scope.selectedLog = $scope.LogList.indexOf(item);
    $scope.selectedLog = {
      "AccID": item.AccID,
      "TranID": item.TranID,
      "TranTime": item.TranTime,
      "AtmID": item.AtmID,
      "TranType": item.TranType,
      "TranNote": item.TranNote,
      "UP_USR": item.UP_USR,
    };
    targetElem = target;
  };
});

ATMApp.service('ATMService', function ($http) {
  return ({
    Load_Trans: Load_Trans,
    Add_Trans: Add_Trans,
    Update_Trans: Update_Trans,
    Delete_Trans: Delete_Trans
  });

  function Load_Trans(QueryKeys) {
    var request = $http({
      method: "GET",
      url: "/api/log",
      params: {
        StartSDate: QueryKeys.StartSDate,
        EndSDate: QueryKeys.EndSDate
      }
    });
    return (request.then(handleSuccess, handleError));
  }

  function Add_Trans(instance) {
    var request = $http({
      method: "POST",
      url: "/api/log",
      params: instance
    });
    return (request.then(handleSuccess, handleError));
  }

  function Update_Trans(instance) {
    instance.method = "update";
    var request = $http({
      method: "POST",
      url: "/api/log",
      params: instance
    });
    return (request.then(handleSuccess, handleError));
  }

  function Delete_Trans(instance) {
    var request = $http({
      method: "POST",
      url: "/api/log",
      params: {
        "method": "delete",
        "TranID": instance.TranID
      }
    });
    return (request.then(handleSuccess, handleError));
  }

  function handleSuccess(response) {
    return (response);
  }

  function handleError(response) {
    return (response);
  }
});